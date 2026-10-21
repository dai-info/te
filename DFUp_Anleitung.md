# DFUp – Programme am Kunden-PC installieren und aktualisieren

`dfup.ps1` holt TE, F2P, CPS und DFCon von <https://d-ai.at/dfup/> in einen
Ordner deiner Wahl (üblicherweise `C:\df`, `C:\dev`, `T:\df` oder `P:\df`).
Kein Login, keine Installation, keine Admin-Rechte.

Ablage im gewählten Ordner, hier am Beispiel `C:\df`:

```
C:\df\dfup.cmd                  Update per Doppelklick
C:\df\cps\                      cps.exe, cpss.exe, libcurl.dll
C:\df\f2p\                      F2P.exe, f2x.exe, TE.exe, DFPanel.exe, DFCon.exe,
                                OpenConsoleProxy.dll, help\*.md (Kurzhilfen für TE)
```

## Erstinstallation

1. Eingabeaufforderung öffnen: `Win+R`, `cmd` eintippen, Enter.
2. Diese Zeile eingeben (oder kopieren) und mit Enter starten:

   ```
   powershell -ep bypass -c "irm https://d-ai.at/dfup/dfup.ps1 | iex"
   ```

3. **Zielordner** bestätigen oder eintippen. Vorgeschlagen wird der erste
   vorhandene von `C:\df`, `C:\dev`, `T:\df`, `P:\df`, `D:\df`. Ein neuer
   Ordner wird angelegt, die Unterordner `cps` und `f2p` ebenfalls.
4. **Auswahl** im Menü:

   ```
     0  nichts (Abbruch)
     1  TE     -> C:\df\f2p
     2  F2P    -> C:\df\f2p
     3  CPS    -> C:\df\cps
     4  DFCon  -> C:\df\f2p
     7  alle
   ```

   Mehrere Ziffern lassen sich kombinieren, `13` holt TE und CPS.

5. Fertig. Im Zielordner liegen die Unterordner `cps` und `f2p` mit den
   Programmen sowie die Datei `dfup.cmd`.

Lagen die Programme bisher direkt im df-Ordner (Stand vor Oktober 2026), räumt
das Skript diese alten Kopien nach dem Umzug in die Unterordner weg.

## Späteres Update

Doppelklick auf `dfup.cmd` im df-Ordner, Auswahl eingeben (oder Enter für
alles), fertig. Vorgeschlagen wird der Ordner, in dem `dfup.cmd` liegt.

## Ohne PowerShell: nur `dfup.cmd`

`dfup.cmd` ist eigenständig und braucht nur `curl.exe`, das seit Windows 10
Version 1803 zu Windows gehört. Wer PowerShell meiden will, nimmt gleich sie:

1. <https://d-ai.at/dfup/dfup.cmd> herunterladen und in den df-Ordner legen,
   zum Beispiel `C:\df`.
2. Doppelklick, Zielordner mit Enter bestätigen, Auswahl eingeben.

Mit Parameter läuft sie ohne Rückfragen: `dfup.cmd 7` holt alles. Beide
Wege, `dfup.ps1` und `dfup.cmd`, liefern dieselben Dateien in dieselbe
Ablage. `dfup.ps1` legt nach dem Lauf die aktuelle `dfup.cmd` in den
df-Ordner.

Laufende Programme müssen nicht geschlossen werden: die alte EXE wird in
`.old` umbenannt und beim nächsten Lauf gelöscht.

## Was geholt wird

| Auswahl | Programm | Ordner | Dateien |
|---|---|---|---|
| 1 | TE | `f2p` | `TE.exe`, `DFPanel.exe`, `help\cps.md`, `help\f2p.md`, `help\form.md` |
| 2 | F2P | `f2p` | `F2P.exe`, `f2x.exe` |
| 3 | CPS | `cps` | `cps.exe`, `cpss.exe`, `libcurl.dll` |
| 4 | DFCon | `f2p` | `DFCon.exe`, `OpenConsoleProxy.dll` |

Quelle ist <https://d-ai.at/dfup/>; dort liegt der jeweils freigegebene Stand,
`versionen.txt` nennt die Versionen. Ist d-ai.at nicht erreichbar, weicht das
Skript auf die GitHub-Releases unter <https://github.com/dai-info> aus.

## Wenn etwas hakt

- **Kein Zugang zu d-ai.at** (Firewall, Proxy): das Skript versucht jede Datei
  zuerst dort und dann bei github.com. Geht beides nicht, `dfup.ps1` und die
  Programmdateien per USB-Stick mitbringen; das Skript im Ordner der Datei
  starten mit `powershell -ep bypass -File dfup.ps1`.
- **SmartScreen** meldet beim ersten Start einer EXE: *Weitere Informationen*,
  dann *Trotzdem ausführen*.
- **FEHLER bei einer Datei** auf einem Netzlaufwerk: ein anderer Benutzer hat
  das Programm gerade offen. Später nochmal `dfup.cmd` starten, der Rest ist
  bereits aktuell.
- **Sehr alter Windows-Stand** ohne PowerShell oder TLS 1.2: ZIP aus dem
  Release von Hand entpacken. Windows 10 und neuer ist nie betroffen.

## TE als Befehl `te` in jedem Fenster (nur für Administratoren)

Die Ziffer `9` in der Auswahl kopiert zusätzlich `TE.exe`, `DFPanel.exe` und
den Ordner `help` nach `C:\Windows\System32`. Dafür erscheint eine
UAC-Abfrage. `79` holt also alles und richtet `te` systemweit ein. Für normale
Kunden-PCs ist das nicht nötig. Bei `dfup.cmd` gibt es keine UAC-Abfrage: sie
muss dafür per Rechtsklick *Als Administrator ausführen* gestartet werden.

## Ohne Rückfragen

Für Batch-Dateien oder Fernwartung lassen sich Zielordner und Auswahl vorab
setzen, dann fragt das Skript nichts:

```
set DFDIR=T:\df
set DFSEL=7
powershell -ep bypass -c "irm https://d-ai.at/dfup/dfup.ps1 | iex"
```

oder mit der reinen Batch-Variante:

```
set DFDIR=T:\df
dfup.cmd 7
```
