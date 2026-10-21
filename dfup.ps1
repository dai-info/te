# dfup.ps1 - DF-Programme von https://d-ai.at/dfup/ in den df-Ordner holen
#            (Ausweichquelle: GitHub-Releases dai-info)
#
# Erstaufruf am Kunden-PC (Eingabeaufforderung oder PowerShell):
#   powershell -ep bypass -c "irm https://d-ai.at/dfup/dfup.ps1 | iex"
# Danach: Doppelklick auf dfup.cmd im df-Ordner.
#
# Ablage im df-Ordner (z.B. C:\df oder C:\dev):
#   df\cps\   cps.exe, cpss.exe, libcurl.dll
#   df\f2p\   F2P.exe, f2x.exe, TE.exe, DFPanel.exe, help\*.md, DFCon.exe, OpenConsoleProxy.dll
#   df\       dfup.cmd
#
# Steuerung ohne Rueckfragen (optional, z.B. fuer dfup.cmd):
#   $env:DFDIR = Zielordner        $env:DFSEL = Menueauswahl (z.B. "1" oder "7")

$pakete = [ordered]@{
  '1' = @{ Name = 'TE';    Repo = 'te';    Ordner = 'f2p'; Dateien = 'TE.exe','DFPanel.exe','help/cps.md','help/f2p.md','help/form.md' }
  '2' = @{ Name = 'F2P';   Repo = 'f2p';   Ordner = 'f2p'; Dateien = 'F2P.exe','f2x.exe' }
  '3' = @{ Name = 'CPS';   Repo = 'cps';   Ordner = 'cps'; Dateien = 'cps.exe','cpss.exe','libcurl.dll' }
  '4' = @{ Name = 'DFCon'; Repo = 'dfcon'; Ordner = 'f2p'; Dateien = 'DFCon.exe','OpenConsoleProxy.dll' }
}
$basisUrl  = 'https://d-ai.at/dfup'
$skriptUrl = "$basisUrl/dfup.ps1"

# --- Zielordner ---------------------------------------------------------------
$df = $env:DFDIR
if (-not $df) {
  $vorschlag = 'C:\df'
  foreach ($k in 'C:\df','C:\dev','T:\df','P:\df','D:\df','T:\dev','D:\dev') { if (Test-Path $k) { $vorschlag = $k; break } }
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
  foreach ($k in $pakete.Keys) { Write-Host ("  $k  {0,-6} -> {1}\{2}" -f $pakete[$k].Name, $df, $pakete[$k].Ordner) }
  Write-Host '  7  alle'
  Write-Host ''
  $sel = Read-Host 'Auswahl (mehrere moeglich, z.B. 13)'
}
$sel = "$sel".Trim()
if (-not $sel -or $sel -eq '0') { Write-Host 'Nichts gemacht.'; return }
$sys32 = $sel -match '9'                       # 9 (nicht im Menue): TE.exe + DFPanel.exe zusaetzlich nach System32
$auswahl = if ($sel -match '7') { @($pakete.Keys) } else { @($sel.ToCharArray() | ForEach-Object { "$_" } | Where-Object { $pakete.Contains($_) }) }
if ($sys32 -and $auswahl -notcontains '1') { $auswahl = @('1') + $auswahl }
if (-not $auswahl) { Write-Host "Ungueltige Auswahl: $sel" -ForegroundColor Red; return }

# --- Download ------------------------------------------------------------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
$fehler = 0
Get-ChildItem $df -Recurse -Filter '*.old' -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue   # Reste vom letzten Lauf bei laufender EXE
function Ersetzen($tmp, $ziel) {
  # laufende EXE laesst sich nicht ueberschreiben, aber umbenennen
  if (Test-Path $ziel) { Move-Item $ziel "$ziel.old" -Force }
  Move-Item $tmp $ziel -Force
  Remove-Item "$ziel.old" -Force -ErrorAction SilentlyContinue
}
foreach ($k in $auswahl) {
  $p = $pakete[$k]
  $zielOrdner = Join-Path $df $p.Ordner
  Write-Host "`n$($p.Name) -> $zielOrdner" -ForegroundColor Yellow
  foreach ($f in $p.Dateien) {
    $urls = @("$basisUrl/$f", "https://github.com/dai-info/$($p.Repo)/releases/latest/download/$(Split-Path $f -Leaf)")
    $ziel = Join-Path $zielOrdner ($f -replace '/', '\')
    New-Item -ItemType Directory -Force (Split-Path $ziel -Parent) | Out-Null
    $tmp  = "$ziel.neu"
    try {
      $geholt = $false
      foreach ($url in $urls) {
        try { Invoke-WebRequest $url -OutFile $tmp -UseBasicParsing; $geholt = $true; break }
        catch { $letzter = $_.Exception.Message; Remove-Item $tmp -Force -ErrorAction SilentlyContinue }
      }
      if (-not $geholt) { throw $letzter }
      Unblock-File $tmp -ErrorAction SilentlyContinue
      Ersetzen $tmp $ziel
      $kb = [int]((Get-Item $ziel).Length / 1KB)
      Write-Host ("  {0,-22} {1,6} KB  ok" -f $f, $kb)
    } catch {
      $fehler++
      Remove-Item $tmp -Force -ErrorAction SilentlyContinue
      Write-Host "  $f  FEHLER: $($_.Exception.Message)" -ForegroundColor Red
    }
  }
  # Alte flache Ablage (vor Oktober 2026 lagen alle Dateien direkt im df-Ordner) aufraeumen
  foreach ($f in $p.Dateien) {
    $alt = Join-Path $df (Split-Path $f -Leaf)
    if ((Test-Path $alt) -and (Test-Path (Join-Path $zielOrdner ($f -replace '/', '\')))) {
      try { Remove-Item $alt -Force -ErrorAction Stop } catch { Move-Item $alt "$alt.old" -Force -ErrorAction SilentlyContinue }
      Write-Host ("  {0,-22} aus {1} entfernt (liegt jetzt in {2})" -f (Split-Path $f -Leaf), $df, $p.Ordner) -ForegroundColor DarkGray
    }
  }
}

# --- 9: TE.exe + DFPanel.exe nach System32 (braucht Admin, fragt sonst per UAC nach) ---
$teOrdner = Join-Path $df 'f2p'
if ($sys32 -and (Test-Path "$teOrdner\TE.exe")) {
  $sysDir = Join-Path $env:windir 'System32'
  Write-Host "`nTE.exe, DFPanel.exe, help\ -> $sysDir" -ForegroundColor Yellow
  $istAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  # Kopierbefehl als cmd-Zeile, damit er auch per UAC in einem Admin-cmd laufen kann
  $cmd = @()
  foreach ($f in 'TE.exe','DFPanel.exe') {
    $q = Join-Path $teOrdner $f; $z = Join-Path $sysDir $f
    $cmd += "(if exist `"$z`" move /y `"$z`" `"$z.old`" >nul) & copy /y `"$q`" `"$z`" >nul & (if exist `"$z.old`" del /q `"$z.old`")"
  }
  $cmd += "(if not exist `"$sysDir\help`" mkdir `"$sysDir\help`") & copy /y `"$teOrdner\help\*.md`" `"$sysDir\help\`" >nul"
  $cmdZeile = $cmd -join ' & '
  try {
    if ($istAdmin) {
      cmd.exe /c $cmdZeile
      if ($LASTEXITCODE -ne 0) { throw "cmd-Exitcode $LASTEXITCODE" }
    } else {
      $pr = Start-Process cmd.exe -ArgumentList "/c $cmdZeile" -Verb RunAs -Wait -PassThru
      if ($pr.ExitCode -ne 0) { throw "cmd-Exitcode $($pr.ExitCode)" }
    }
    Write-Host "  kopiert, 'te' startet jetzt aus jedem Fenster"
  } catch {
    $fehler++
    Write-Host "  FEHLER: $($_.Exception.Message)" -ForegroundColor Red
  }
}

# --- dfup.cmd fuer spaetere Updates per Doppelklick ------------------------------
# Die eigenstaendige dfup.cmd (nur curl.exe, kein PowerShell) von d-ai.at holen;
# falls das nicht klappt, einen Starter schreiben, der wieder dieses Skript aufruft.
$cmdZiel = Join-Path $df 'dfup.cmd'
try {
  Invoke-WebRequest "$basisUrl/dfup.cmd" -OutFile "$cmdZiel.neu" -UseBasicParsing
  Move-Item "$cmdZiel.neu" $cmdZiel -Force
} catch {
  Remove-Item "$cmdZiel.neu" -Force -ErrorAction SilentlyContinue
  @"
@echo off
rem DF-Programme aktualisieren - Doppelklick genuegt
set "DFDIR=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm $skriptUrl | iex"
pause
"@ | Set-Content $cmdZiel -Encoding ASCII
}

Write-Host ''
if ($fehler) { Write-Host "Fertig mit $fehler Fehler(n)." -ForegroundColor Red }
else { Write-Host "Fertig. Naechstes Update: Doppelklick auf $df\dfup.cmd" -ForegroundColor Green }
