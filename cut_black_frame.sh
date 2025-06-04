#!/bin/bash

# Check if ImageMagick's convert command is available
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed or 'convert' command is not found."
    exit 1
fi

# Loop through all selected files passed as arguments
for img in "$@"; do
    # Check if the file is a PNG or JPG
    if [[ "$img" == *.png || "$img" == *.jpg ]]; then
        # Trim black borders from the image
        convert "$img" -fuzz 10% -trim +repage "$img"

        # Check if the trim was successful
        if [[ $? -eq 0 ]]; then
            echo "Trimmed black borders from $img"
        else
            echo "Failed to trim $img"
        fi
    else
        echo "Skipping $img: Not a PNG or JPG file."
    fi
done
