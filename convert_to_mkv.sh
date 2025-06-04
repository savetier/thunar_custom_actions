#!/bin/bash
for file in "$@"; do
    case "$file" in
        *.mp4|*.MP4)
            ffmpeg -i "$file" -c copy "${file%.mp4}.mkv"
            ;;
        *.webm|*.WEBM)
            ffmpeg -i "$file" -c copy "${file%.webm}.mkv"
            ;;
        *)
            echo "Unsupported file type: $file"
            ;;
    esac
done
