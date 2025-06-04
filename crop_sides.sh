#!/bin/bash

# Überprüfen, ob ein Argument (Dateipfad) übergeben wurde
if [ "$#" -ne 1 ]; then
    zenity --error --text="Bitte wähle ein TIF-Bild aus."
    exit 1
fi

# Dateipfad des TIF-Bildes
input_file="$1"

# Zenity-Fenster für die Eingabe der Beschnittwerte
crop_values=$(zenity --forms --title="Bildbeschnitt" --text="Gib die Beschnittwerte in Pixeln an:" \
    --add-entry="Oben:" \
    --add-entry="Unten:" \
    --add-entry="Links:" \
    --add-entry="Rechts:")

# Überprüfen, ob der Benutzer auf "Abbrechen" geklickt hat
if [ $? -ne 0 ]; then
    exit 0
fi

# Beschnittwerte extrahieren
IFS='|' read -r top bottom left right <<< "$crop_values"

# Debugging-Ausgaben
echo "Top: '$top'"
echo "Bottom: '$bottom'"
echo "Left: '$left'"
echo "Right: '$right'"

# Standardwerte auf 0 setzen, wenn keine Eingabe erfolgt ist
top=${top:-0}
bottom=${bottom:-0}
left=${left:-0}
right=${right:-0}

# Überprüfen, ob die Eingaben gültige Zahlen sind
if ! [[ "$top" =~ ^[0-9]+$ ]] || ! [[ "$bottom" =~ ^[0-9]+$ ]] || ! [[ "$left" =~ ^[0-9]+$ ]] || ! [[ "$right" =~ ^[0-9]+$ ]]; then
    zenity --error --text="Bitte gib gültige positive Ganzzahlen für den Beschnitt an."
    exit 1
fi

# Dateiname und temporäre Datei für das beschnittene Bild
output_file="${input_file%.tif}_cropped.tif"

# Bild mit ImageMagick beschneiden
convert "$input_file" -crop +$left+$top -crop -$right-$bottom +repage "$output_file"

# Überprüfen, ob der Beschnitt erfolgreich war
if [ $? -eq 0 ]; then
    zenity --info --text="Das Bild wurde erfolgreich beschnitten und gespeichert:\n$output_file"
else
    zenity --error --text="Fehler beim Beschnitt des Bildes."
    exit 1
fi
