# TE — Texteditor mit Syntax-Hervorhebung

TE ist ein schlanker Texteditor für Windows auf Basis der Scintilla-Komponente. Er ist auf die Skript- und Vorlagensprachen unserer Anwendungen zugeschnitten — `.cps` (cURL Programming Script), `.f2p` (Flex2PDF-Vorlagen) und Formularquellen — und bringt für diese Dateitypen eigene Syntax-Hervorhebung und eine eingebaute Kurzhilfe mit.

Zum Paket gehört **View** als Anzeigekomponente: TE übergibt Markdown-, HTML- und RTF-Dateien an View, das sie gerendert darstellt. Beide Programme arbeiten zusammen, gehören also in denselben Ordner.

## Download

Die aktuelle Version steht unter **[Releases](../../releases)** als ZIP-Paket bereit. Inhalt:

| Datei | Zweck |
|---|---|
| `TE.exe` | Editor |
| `View.exe` | Anzeige für Markdown, HTML und RTF |
| `help\cps.md` | Kurzhilfe zum Dateityp `.cps` |
| `help\f2p.md` | Kurzhilfe zum Dateityp `.f2p` |
| `help\form.md` | Kurzhilfe zu Formularquellen |

**Installation:** ZIP in einen beliebigen Ordner entpacken — keine Installation, keine Admin-Rechte nötig. `TE.exe`, `View.exe` und der Ordner `help` müssen beieinander bleiben.

## Bedienung

```
TE.exe datei.cps
```

| Taste | Wirkung |
|---|---|
| `Shift+F1` | Kurzhilfe zum aktuellen Dateityp, `Esc` schließt sie |
| `Strg+D` | in View: Fenster anheften, damit es nicht ersetzt wird |

Mit dem Schalter `/e` liest TE Dateien in älteren 8-Bit-Kodierungen ein und wandelt sie beim Laden nach UTF-8.

## Funktionen

- Syntax-Hervorhebung für `.cps`, `.f2p`, Formularquellen sowie SQL, JSON, XML, Markdown und Batch
- Kurzhilfe je Dateityp direkt im Editor
- Anzeige von Markdown, HTML und RTF über View
- Suchen und Ersetzen mit regulären Ausdrücken
- Zeilennummern und Lesezeichen
- UTF-8 und UTF-16, Umwandlung älterer Kodierungen beim Laden
- Frei einstellbare Farben und Schriften
- Portabel, geringer Speicherbedarf

## Systemvoraussetzungen

- Windows 10/11, 64-Bit
- Für die Anzeige in View: Microsoft Edge WebView2 Runtime (auf aktuellen Windows-Installationen bereits vorhanden)

## Änderungen

Was sich von Version zu Version geändert hat, steht im **[CHANGELOG.md](CHANGELOG.md)**.

## Rechtliches und Herkunft

TE steht unter der MIT-Lizenz. Das Programm baut auf Vorarbeiten auf, die hier ausdrücklich genannt seien:

- **Notepad2** von Florian Balmer — Grundlage der Editor-Oberfläche
- **Scintilla** und **Lexilla** von Neil Hodgson — Editor- und Lexer-Komponente
- **cmark-gfm** (GitHub) — Markdown-Aufbereitung
- **WebView2** (Microsoft) — Anzeigekomponente in View

Die jeweiligen Lizenzbedingungen dieser Bestandteile gelten fort.
