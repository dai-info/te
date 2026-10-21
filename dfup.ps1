# dfup.ps1 - DF-Programme aus den GitHub-Releases (dai-info) in den df-Ordner holen
#
# Erstaufruf am Kunden-PC (Eingabeaufforderung oder PowerShell):
#   powershell -ep bypass -c "irm https://raw.githubusercontent.com/dai-info/te/main/dfup.ps1 | iex"
# Danach: Doppelklick auf dfup.cmd im df-Ordner.
#
# Steuerung ohne Rueckfragen (optional, z.B. fuer dfup.cmd):
#   $env:DFDIR = Zielordner        $env:DFSEL = Menueauswahl (z.B. "1" oder "7")

$pakete = [ordered]@{
  '1' = @{ Name = 'TE';    Repo = 'te';    Dateien = 'TE.exe','DFPanel.exe' }
  '2' = @{ Name = 'F2P';   Repo = 'f2p';   Dateien = 'F2P.exe','f2x.exe' }
  '3' = @{ Name = 'CPS';   Repo = 'cps';   Dateien = 'cps.exe','cpss.exe','libcurl.dll' }
  '4' = @{ Name = 'DFCon'; Repo = 'dfcon'; Dateien = 'DFCon.exe','OpenConsoleProxy.dll' }
}
$skriptUrl = 'https://raw.githubusercontent.com/dai-info/te/main/dfup.ps1'

# --- Zielordner ---------------------------------------------------------------
$df = $env:DFDIR
if (-not $df) {
  $vorschlag = 'C:\df'
  foreach ($k in 'C:\df','T:\df','P:\df','D:\df') { if (Test-Path $k) { $vorschlag = $k; break } }
  $eingabe = Read-Host "Zielordner [$vorschlag]"
  $df = if ($eingabe.Trim()) { $eingabe.Trim() } else { $vorschlag }
}
$df = $df.TrimEnd('\')
New-Item -ItemType Directory -Force $df | Out-Null
Write-Host "df-Ordner: $df" -ForegroundColor Cyan

# --- Menue ---------------------------------------------------------------------
$sel = $env:DFSEL
if (-not $sel) {
  Write-Host ''
  Write-Host '  0  nichts (Abbruch)'
  foreach ($k in $pakete.Keys) { Write-Host "  $k  $($pakete[$k].Name)" }
  Write-Host '  7  alle'
  Write-Host ''
  $sel = Read-Host 'Auswahl (mehrere moeglich, z.B. 13)'
}
$sel = "$sel".Trim()
if (-not $sel -or $sel -eq '0') { Write-Host 'Nichts gemacht.'; return }
$sys32 = $sel -match '9'                       # 9 (nicht im Menue): TE.exe zusaetzlich nach System32
$auswahl = if ($sel -match '7') { @($pakete.Keys) } else { @($sel.ToCharArray() | ForEach-Object { "$_" } | Where-Object { $pakete.Contains($_) }) }
if ($sys32 -and $auswahl -notcontains '1') { $auswahl = @('1') + $auswahl }
if (-not $auswahl) { Write-Host "Ungueltige Auswahl: $sel" -ForegroundColor Red; return }

# --- Download ------------------------------------------------------------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
$fehler = 0
Remove-Item "$df\*.old" -Force -ErrorAction SilentlyContinue   # Reste vom letzten Lauf bei laufender EXE
foreach ($k in $auswahl) {
  $p = $pakete[$k]
  Write-Host "`n$($p.Name) (github.com/dai-info/$($p.Repo), neuestes Release)" -ForegroundColor Yellow
  foreach ($f in $p.Dateien) {
    $url  = "https://github.com/dai-info/$($p.Repo)/releases/latest/download/$f"
    $ziel = Join-Path $df $f
    $tmp  = "$ziel.neu"
    try {
      Invoke-WebRequest $url -OutFile $tmp -UseBasicParsing
      Unblock-File $tmp -ErrorAction SilentlyContinue
      # laufende EXE laesst sich nicht ueberschreiben, aber umbenennen
      if (Test-Path $ziel) { Move-Item $ziel "$ziel.old" -Force }
      Move-Item $tmp $ziel -Force
      Remove-Item "$ziel.old" -Force -ErrorAction SilentlyContinue
      $kb = [int]((Get-Item $ziel).Length / 1KB)
      Write-Host ("  {0,-20} {1,6} KB  ok" -f $f, $kb)
    } catch {
      $fehler++
      Remove-Item $tmp -Force -ErrorAction SilentlyContinue
      Write-Host "  $f  FEHLER: $($_.Exception.Message)" -ForegroundColor Red
    }
  }
}

# --- 9: TE.exe nach System32 (braucht Admin, fragt sonst per UAC nach) -----------
if ($sys32 -and (Test-Path "$df\TE.exe")) {
  $zielSys = Join-Path $env:windir 'System32\TE.exe'
  Write-Host "`nTE.exe -> $zielSys" -ForegroundColor Yellow
  $istAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  try {
    if ($istAdmin) {
      if (Test-Path $zielSys) { Move-Item $zielSys "$zielSys.old" -Force }
      Copy-Item "$df\TE.exe" $zielSys -Force
      Remove-Item "$zielSys.old" -Force -ErrorAction SilentlyContinue
    } else {
      $cmd = "(if exist `"$zielSys`" move /y `"$zielSys`" `"$zielSys.old`") & copy /y `"$df\TE.exe`" `"$zielSys`" && (if exist `"$zielSys.old`" del /q `"$zielSys.old`")"
      $pr = Start-Process cmd.exe -ArgumentList "/c $cmd" -Verb RunAs -Wait -PassThru
      if ($pr.ExitCode -ne 0) { throw "cmd-Exitcode $($pr.ExitCode)" }
    }
    Write-Host "  kopiert, 'te' startet jetzt aus jedem Fenster"
  } catch {
    $fehler++
    Write-Host "  FEHLER: $($_.Exception.Message)" -ForegroundColor Red
  }
}

# --- dfup.cmd fuer spaetere Updates per Doppelklick ------------------------------
@"
@echo off
rem DF-Programme aktualisieren - Doppelklick genuegt
set "DFDIR=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm $skriptUrl | iex"
pause
"@ | Set-Content (Join-Path $df 'dfup.cmd') -Encoding ASCII

Write-Host ''
if ($fehler) { Write-Host "Fertig mit $fehler Fehler(n)." -ForegroundColor Red }
else { Write-Host "Fertig. Naechstes Update: Doppelklick auf $df\dfup.cmd" -ForegroundColor Green }
