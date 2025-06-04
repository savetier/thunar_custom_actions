#!/bin/bash

# Verzeichnis mit den Bilddateien
input_file="$1"
output_suffix="_bearbeitet"

# Dateiname ohne Endung
filename=$(basename "$input_file" .tif)

# Passen Sie zunächst den Kontrast an, dann konvertieren Sie in Graustufen
convert "$input_file" -auto-level -contrast-stretch 10% -brightness-contrast 25x25 "$filename$output_suffix.tif"
convert "$filename$output_suffix.tif" -grayscale Rec709Luma "$filename$output_suffix.tif"

echo "Die Bildbearbeitung für $filename$output_suffix.tif ist abgeschlossen."
