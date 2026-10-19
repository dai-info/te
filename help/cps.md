# CPS – Curl Program Script

> Hilfe zum Dateityp `.cps` (auch `.cpu`, `.cpy`, `.cpx`).
> Anzeige über **Hilfe zum Dateityp** (`Shift+F1`), `Esc` schließt wieder.

---

## Überblick

CPS-Skripte automatisieren HTTP/REST-Aufrufe, JSON/XML-Extraktion, Datei-
und Mailoperationen — typisch als Brücke zwischen DataFlex-Anwendungen und
Web-APIs. Ein Skript ist eine Folge von Zeilenbefehlen; der Lexer hebt
Befehle, `if`-Schlüsselwörter, Variablenreferenzen `(%name)`, Labels
`:name` und relative Sprünge `+N` hervor.

## Syntax-Grundlagen

- **Kommentare:** `#` oder `*` am Zeilenanfang, ebenso `//`.
- **Variablen:** Zuweisung `%name wert` / `%name = wert` / `name: wert`;
  Referenz `(%name)`, Systemvariablen `(%http_code%)`, Prozessoren
  `(%name lower)` — verkettbar.
- **Labels und Sprünge:** `:label` definiert, `goto`/`gosub` springen,
  `+N` springt N Zeilen vorwärts (1–32).
- **Ausgabe:** `> Text` mit Farbtags wie `[cyan]`, `[green]`, `[#0]` (Reset).
- **HTTP-Block:** beginnt mit `!> URL optionen`, Folgezeilen sind Header/Body,
  eine Leerzeile beendet den Block. `!<` extrahiert aus der Antwort.

```cps
# Beispielzeile – wird in der Vorschau farblich hervorgehoben
%kunde = Anna Muster
if %kunde :gefunden else :fehlt
```

## Schlüsselwörter

**Zeilenbefehle** (Wortliste `lineCommands` des Lexers):

| Schlüsselwort | Bedeutung | Beispiel |
|---------------|-----------|----------|
| `goto` / `gosub` / `return` | Sprung / Subroutine (max. 1 Ebene) | `gosub :pruefen` |
| `include` | Datei mit `name: wert`-Zeilen als Variablen laden | `include werte.txt` |
| `shell` / `run` / `runw` | Prozess starten (`runw` wartet, Exit-Code in `(%curlrc%)`) | `runw cmd /c dir` |
| `pause` / `pause$` | Auf Taste warten, Ergebnis in `(%lastkey%)` | `pause 10 Weiter?` |
| `setlog` | Logging ein/aus (`0/1/2`, optional Datei) | `setlog 1 lauf.log` |
| `extract` | Werte per Muster/JSON/XML extrahieren | `extract json %id=kunde.id` |
| `exit` | Skript beenden (optional mit Code) | `exit 1` |
| `pmdump` | Post-Mortem-Dump nach ERRLOG schreiben | `pmdump Fehlertext` |
| `call` / `sleep` | Unterprogramm / Wartezeit | `sleep 2` |

**IF-Schlüsselwörter** (Wortliste `ifKeywords`): `if`, `ifnot`, `then`,
`else`, `undef`, `next`, `in`

```cps
if %rc = 0 then :ok else :fehler undef :nicht_gesetzt
if "muster" in %name :enthalten
ifnot %token :token_fehlt
```

## Beispiel

```cps
# Mini-Beispiel: Variable, Bedingung, Subroutine
%wer = Welt
gosub :gruss
exit 0

:gruss
> [green]Hallo, (%wer)![#0]
return
```

## Siehe auch

- Verwandte Dateitypen: `.f2p`, Formular
- Lauffähige Beispiele mit Ergebnissen:
  <https://github.com/dai-info/cps/tree/master/beispiele>
- Vollständige Referenz (Benutzerhandbuch):
  <https://github.com/dai-info/cps/blob/master/CPS_Anleitung.md>

---

Download, Anleitung und Changelog: <https://github.com/dai-info/te>  
Alle Programme: <https://github.com/dai-info>
