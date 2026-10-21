# DFUp – Programme am Kunden-PC installieren und aktualisieren

`dfup.ps1` holt TE, F2P, CPS und DFCon direkt aus den GitHub-Releases in einen
Ordner deiner Wahl (üblicherweise `C:\df`, `T:\df` oder `P:\df`). Kein Login,
keine Installation, keine Admin-Rechte.

## Erstinstallation

1. Eingabeaufforderung öffnen: `Win+R`, `cmd` eintippen, Enter.
2. Diese Zeile eingeben (oder kopieren) und mit Enter starten:

   ```
   powershell -ep bypass -c "irm https://raw.githubusercontent.com/dai-info/te/main/dfup.ps1 | iex"
   ```

3. **Zielordner** bestätigen oder eintippen. Vorgeschlagen wird der erste
   vorhandene von `C:\df`, `T:\df`, `P:\df`, `D:\df`. Ein neuer Ordner wird
   angelegt.
4. **Auswahl** im Menü:

   ```
     0  nichts (Abbruch)
     1  TE
     2  F2P
     3  CPS
     4  DFCon
     7  alle
   ```

   Mehrere Ziffern lassen sich kombinieren, `13` holt TE und CPS.

5. Fertig. Im Zielordner liegen die Programme und die Datei `dfup.cmd`.

## Späteres Update

Doppelklick auf `dfup.cmd` im df-Ordner, Auswahl eingeben, fertig. Der
Zielordner wird nicht mehr abgefragt, es ist immer der Ordner, in dem
`dfup.cmd` liegt.

Laufende Programme müssen nicht geschlossen werden: die alte EXE wird in
`.old` umbenannt und beim nächsten Lauf gelöscht.

## Was geholt wird

| Auswahl | Programm | Dateien |
|---|---|---|
| 1 | TE | `TE.exe`, `DFPanel.exe` |
| 2 | F2P | `F2P.exe`, `f2x.exe` |
| 3 | CPS | `cps.exe`, `cpss.exe`, `libcurl.dll` |
| 4 | DFCon | `DFCon.exe`, `OpenConsoleProxy.dll` |

Quelle ist jeweils das neueste Release unter <https://github.com/dai-info>.

## Wenn etwas hakt

- **Kein Zugang zu github.com** (Firewall, Proxy): `dfup.ps1` per USB-Stick
  mitbringen und im Ordner der Datei starten mit
  `powershell -ep bypass -File dfup.ps1`. Die Programmdateien selbst kommen
  trotzdem von github.com, ohne Zugang bleibt nur das ZIP aus dem Release.
- **SmartScreen** meldet beim ersten Start einer EXE: *Weitere Informationen*,
  dann *Trotzdem ausführen*.
- **FEHLER bei einer Datei** auf einem Netzlaufwerk: ein anderer Benutzer hat
  das Programm gerade offen. Später nochmal `dfup.cmd` starten, der Rest ist
  bereits aktuell.
- **Sehr alter Windows-Stand** ohne PowerShell oder TLS 1.2: ZIP aus dem
  Release von Hand entpacken. Windows 10 und neuer ist nie betroffen.

## Ohne Rückfragen

Für Batch-Dateien oder Fernwartung lassen sich Zielordner und Auswahl vorab
setzen, dann fragt das Skript nichts:

```
set DFDIR=T:\df
set DFSEL=7
powershell -ep bypass -c "irm https://raw.githubusercontent.com/dai-info/te/main/dfup.ps1 | iex"
```
