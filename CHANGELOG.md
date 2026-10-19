# Changelog

Alle für Anwender relevanten Änderungen an TE.

## v19.10.26 — Stand 2026-10-19

### Geändert

- **Die Anzeigekomponente heißt jetzt DFPanel** (`DFPanel.exe` statt
  `View.exe`). TE startet sie neben sich; nach dem Aktualisieren kann die alte
  `View.exe` gelöscht werden.

### Neu

- **Einstellungen direkt in TE bearbeiten:** `Strg+F7` öffnet die INI-Datei in
  einem eigenen Dialog mit Syntaxfärbung. Nach dem Speichern greifen Tabs,
  Umbruch, Ränder, Farben und Schrift sofort. Es wird keine zweite
  Programminstanz mehr gestartet.
- **DFPanel:** Pin-Schaltfläche direkt in jeder angezeigten Seite;
  Rechtsklick-Menü als Windows-Menü mit Untermenüs und rechtsbündigen
  Tastenkürzeln, folgt dem Dunkelmodus von Windows.
- **Kurzhilfe `.cps`** (`Shift+F1`) mit allen Schlüsselwörtern und Links zu
  den Beispielen gefüllt.
- Der About-Dialog zeigt die Download-Adresse
  <https://github.com/dai-info/te>; die Schaltfläche *GitHub dai-info*
  öffnet sie. Die Kurzhilfen verweisen ebenfalls dorthin.

### Verbessert

- **Menüs verschlankt:** ungenutzte Bearbeiten-Funktionen (Convert, Enclose
  Selection, Modify Lines, Align, Insert Tag, Zoom-Einträge, zweites
  Standardschema) und ihre Tastenkürzel sind entfernt.
- **Scintilla 5.6.7 und Lexilla 5.5.4**, WebView2-SDK aktualisiert.
- `DFPanel.exe` trägt die Versionsnummer in den Dateieigenschaften, so lässt
  sich ein Programmstand ohne Start prüfen.
- INI-Dialog: `Esc` fügt kein Steuerzeichen mehr ein, beim Fokussieren wird
  nicht mehr der gesamte Text markiert.

## v23.08.26 — Stand 2026-08-23

Erste hier veröffentlichte Fassung. Sie fasst die Entwicklung des laufenden
Jahres zusammen.

### Neu

- **View als Anzeigekomponente.** Markdown-, HTML- und RTF-Dateien werden in einem eigenen Fenster gerendert dargestellt, statt als Quelltext. TE reicht die Datei an View weiter.
- **Fenster anheften (`Strg+D`).** Ein angeheftetes Anzeigefenster wird beim Öffnen der nächsten Datei nicht ersetzt — praktisch, um zwei Ansichten nebeneinander zu behalten. Zusätzlich gibt es dafür eine Schaltfläche direkt in der Anzeige.
- **Rechtsklick-Menü in der Anzeige** mit Aktionen zum Andocken der Fenster.
- **Syntax-Hervorhebung für Flex2PDF-Vorlagen (`.f2p`)** und für Formularquellen.
- **Kurzhilfe je Dateityp** mit `Shift+F1`: eine knappe Referenz zur Syntax der gerade geöffneten Datei, `Esc` schließt sie wieder.
- **Ältere Kodierungen einlesen.** Mit dem Schalter `/e` wandelt TE 8-Bit-Dateien beim Laden nach UTF-8 — nützlich für Altbestände aus DOS- und Windows-Zeichensätzen.
- **HTML in die Zwischenablage**, Öffnen von URLs, und Maximieren auf den Arbeitsbereich.

### Verbessert

- **Scintilla auf 5.6.2 und Lexilla auf 5.4.9** aktualisiert — schnellere Darstellung großer Dateien und Fehlerbehebungen der Editor-Komponente.
- Zahlreiche Verbesserungen an der `.cps`-Hervorhebung.
