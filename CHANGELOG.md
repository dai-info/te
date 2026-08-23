# Changelog

Alle für Anwender relevanten Änderungen an TE.

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
