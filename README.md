# TE — Texteditor mit Syntax-Hervorhebung

TE ist ein schlanker Texteditor für Windows auf Basis der Scintilla-Komponente. Er ist auf die Skript- und Vorlagensprachen unserer Anwendungen zugeschnitten — `.cps` (cURL Programming Script), `.f2p` (Flex2PDF-Vorlagen) und Formularquellen — und bringt für diese Dateitypen eigene Syntax-Hervorhebung und eine eingebaute Kurzhilfe mit.

Zum Paket gehört **DFPanel** als Anzeigekomponente (bis v03.09.26 hieß sie *View*): TE übergibt Markdown-, HTML- und RTF-Dateien an DFPanel, das sie gerendert darstellt. Beide Programme arbeiten zusammen, gehören also in denselben Ordner.

## Download

Die aktuelle Version steht unter **[Releases](../../releases)** als ZIP-Paket bereit. Inhalt:

| Datei | Zweck |
|---|---|
| `TE.exe` | Editor |
| `DFPanel.exe` | Anzeige für Markdown, HTML und RTF (früher `View.exe`) |
| `help\cps.md` | Kurzhilfe zum Dateityp `.cps` |
| `help\f2p.md` | Kurzhilfe zum Dateityp `.f2p` |
| `help\form.md` | Kurzhilfe zu Formularquellen |

**Installation:** ZIP in einen beliebigen Ordner entpacken — keine Installation, keine Admin-Rechte nötig. `TE.exe`, `DFPanel.exe` und der Ordner `help` müssen beieinander bleiben. Beim Aktualisieren einer älteren Version kann die alte `View.exe` gelöscht werden.

Im Menü `?` → *About* steht die Version; die Schaltfläche *GitHub dai-info* öffnet diese Seite.

## Bedienung

```
TE.exe datei.cps
```

| Taste | Wirkung |
|---|---|
| `Shift+F1` | Kurzhilfe zum aktuellen Dateityp, `Esc` schließt sie |
| `F12` | aktuelle Datei in DFPanel anzeigen |
| `Strg+F7` | Einstellungen (INI) direkt in TE bearbeiten, Speichern wirkt sofort |
| `Strg+D` | in DFPanel: Fenster anheften, damit es nicht ersetzt wird (auch per Pin-Schaltfläche in der Seite) |

Mit dem Schalter `/e` liest TE Dateien in älteren 8-Bit-Kodierungen ein und wandelt sie beim Laden nach UTF-8.

## Funktionen

- Syntax-Hervorhebung für `.cps`, `.f2p`, Formularquellen sowie SQL, JSON, XML, Markdown und Batch
- Kurzhilfe je Dateityp direkt im Editor
- Anzeige von Markdown, HTML und RTF über DFPanel, mit Pin-Schaltfläche, Rechtsklick-Menü und Dunkelmodus
- Einstellungen direkt im Editor bearbeiten
- Suchen und Ersetzen mit regulären Ausdrücken
- Zeilennummern und Lesezeichen
- UTF-8 und UTF-16, Umwandlung älterer Kodierungen beim Laden
- Frei einstellbare Farben und Schriften
- Portabel, geringer Speicherbedarf

## Systemvoraussetzungen

- Windows 10/11, 64-Bit
- Für die Anzeige in DFPanel: Microsoft Edge WebView2 Runtime (auf aktuellen Windows-Installationen bereits vorhanden)

## Änderungen

Was sich von Version zu Version geändert hat, steht im **[CHANGELOG.md](CHANGELOG.md)**.

## Weitere Programme

Alle unsere Programme mit Downloads, Changelogs und Anleitungen liegen zentral
unter **<https://github.com/dai-info>**:

| Programm | Zweck |
|---|---|
| [TE](https://github.com/dai-info/te) | Texteditor mit Syntax-Hervorhebung (dieses Repo) |
| [F2P](https://github.com/dai-info/f2p) | PDF-, Druck-, Bild- und Excel-Ausgabe aus `.f2p`-Vorlagen |
| [CPS](https://github.com/dai-info/cps) | Windows-Skript-Interpreter für `.cps` |
| [DFCon](https://github.com/dai-info/dfcon) | DataFlex-Konsole |

## Rechtliches und Herkunft

TE steht unter der MIT-Lizenz. Das Programm baut auf Vorarbeiten auf, die hier ausdrücklich genannt seien:

- **Notepad2** von Florian Balmer — Grundlage der Editor-Oberfläche
- **Scintilla** und **Lexilla** von Neil Hodgson — Editor- und Lexer-Komponente
- **cmark-gfm** (GitHub) — Markdown-Aufbereitung
- **WebView2** (Microsoft) — Anzeigekomponente in DFPanel

Die jeweiligen Lizenzbedingungen dieser Bestandteile gelten fort.
