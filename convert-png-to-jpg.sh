#!/bin/bash

# Check if ImageMagick's convert command is available
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed or 'convert' command is not found."
    exit 1
fi

# Loop through all PNG files in the current directory
shopt -s nullglob  # Enable nullglob to handle no matches
png_files=(*.png)

if [ ${#png_files[@]} -eq 0 ]; then
    echo "No PNG files found in the directory."
    exit 0
fi

# Create a temporary directory for converted files
mkdir -p converted

# Convert PNG files to JPG
for img in "${png_files[@]}"; do
    # Convert the image to JPG format and save it in the 'converted' directory
    convert "$img" "converted/${img%.png}.jpg"

    # Check if the conversion was successful
    if [[ $? -eq 0 ]]; then
        echo "Converted $img to JPG format."
    else
        echo "Failed to convert $img."
    fi
done
