#!/bin/bash

# Check if ImageMagick's convert command is available
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed or 'convert' command is not found."
    exit 1
fi

# Check if Zenity is installed
if ! command -v zenity &> /dev/null; then
    echo "Error: Zenity is not installed."
    exit 1
fi

# Prompt the user for the desired size using Zenity
size=$(zenity --entry --title="Resize Images" --text="Enter the desired size (e.g., 800x600):")

# Check if the user canceled the dialog
if [ $? -ne 0 ]; then
    echo "Operation canceled."
    exit 0
fi

# Ask if the user wants to keep the aspect ratio
keep_aspect=$(zenity --question --title="Keep Aspect Ratio" --text="Do you want to keep the aspect ratio?" --ok-label="Yes" --cancel-label="No")

# Loop through all image files in the current directory
shopt -s nullglob  # Enable nullglob to handle no matches
image_files=(*.jpg *.png *.tif *.tiff)

if [ ${#image_files[@]} -eq 0 ]; then
    zenity --info --text="No image files found in the directory."
    exit 0
fi

# Resize images
for img in "${image_files[@]}"; do
    if [ $? -eq 0 ]; then
        if [ "$keep_aspect" -eq 0 ]; then
            # Keep aspect ratio
            convert "$img" -resize "$size" "$img"
        else
            # Resize without keeping aspect ratio
            convert "$img" -resize "${size}!" "$img"
        fi

        # Check if the resize was successful
        if [[ $? -eq 0 ]]; then
            echo "Resized $img to $size"
        else
            echo "Failed to resize $img"
        fi
    fi
done

zenity --info --text="Image resizing completed."
