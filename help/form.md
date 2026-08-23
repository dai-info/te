# Formular (Flex2PDF-Quelle)

> Hilfe zum Formular-Dateityp. Aufruf über **Hilfe zum Dateityp** (`Shift+F1`),
> `Esc` schließt die Hilfe. Aufbau analog zu [`cps.md`](cps.md).

---

## Überblick

Das Formular ist die **Quelle**, aus der das Programm die fertige `.f2p`-Datei
erzeugt. Es ist ein **Superset** von `.f2p`: es enthält denselben Template-Code
plus eine zusätzliche Präprozessor-Schicht, die beim Erzeugen ausgewertet wird
und in der fertigen `.f2p` nicht mehr vorkommt.

## Syntax-Grundlagen

- **Feld-/Kopfzeile:** komma-getrennt, letztes Feld = Encoding/Format/Font.
- **Präprozessor-Anweisungen:** werden beim Erzeugen aufgelöst.
- **Template-Code:** identisch zu `.f2p` (siehe [`f2p.md`](f2p.md)).

```form
# Beispiel: Präprozessor + Template-Code auf einer Zeile
Feld1,Feld2,UTF-8   {{T3-[S
```

## Präprozessor-Elemente (Auswahl)

| Element     | Bedeutung       | Beispiel     |
|-------------|-----------------|--------------|
| `{W7.1L2}`  | *(beschreiben)* | `{W7.1L2}`   |
| `{D1.1}`    | *(beschreiben)* | `{D1.1}`     |

## Siehe auch

- Ergebnis: `.f2p` ([`f2p.md`](f2p.md))
- Verwandt: `.cps` ([`cps.md`](cps.md))
