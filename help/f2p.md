# F2P – Flex2PDF-Template

> Hilfe zum Dateityp `.f2p`. Aufruf über **Hilfe zum Dateityp** (`Shift+F1`),
> `Esc` schließt die Hilfe. Aufbau analog zu [`cps.md`](cps.md).

---

## Überblick

`.f2p`-Dateien sind fertige Druck-Templates für Flex2PDF. Anders als bei `.cps`
bestimmt nicht das erste Zeichen der Zeile den Typ – eine Zeile besteht aus
normalem Text plus eingebetteten Steuersegmenten.

## Syntax-Grundlagen

- **Segmente** beginnen mit `[` gefolgt von einem Präfix.
- **Kopfzeile:** beschreibt Encoding/Format/Font.
- Hier weitere Regeln ergänzen.

```f2p
# Beispielzeile mit Steuersegment
{{T3-[S Beispieltext
```

## Steuersegmente (Auswahl)

| Präfix | Bedeutung          | Beispiel        |
|--------|--------------------|-----------------|
| `[S`   | *(beschreiben)*    | `[S …`          |
| `[=`   | *(beschreiben)*    | `[= …`          |

## Siehe auch

- Quelle des Templates: Formular (`form.md`)
- Verwandt: `.cps` ([`cps.md`](cps.md))

---

Download, Anleitung und Changelog: <https://github.com/dai-info/te>  
Alle Programme: <https://github.com/dai-info>
