#!/bin/bash

for file in "$@"; do
    case "$file" in
        *.mkv|*.MKV)
            # Use mkvpropedit to remove metadata from MKV files
            mkvpropedit "$file" --tags all:
            echo "Metadata removed from $file"
            ;;
        *.mp4|*.MP4)
            # Extract the base name of the file
            base_name=$(basename "$file")
            # Construct the output file name
            output_file="${base_name%.mp4}_no_metadata.mp4"
            # Use ffmpeg to remove metadata from MP4 files
            ffmpeg -i "$file" -c copy -map 0 -metadata title="" -metadata artist="" -metadata album="" -metadata genre="" -metadata date="" -metadata comment="" -metadata description="" -metadata LongDescription="" -metadata encoder="" -metadata handler_name="" -metadata creation_time="" -metadata location="" -metadata publisher="" -metadata writer="" -metadata performer="" -metadata track="" -metadata disc="" -metadata album_artist="" -metadata composer="" -metadata disc_number="" -metadata track_number="" -metadata disc_total="" -metadata track_total="" -metadata disc_subtitle="" -metadata disc_title="" -metadata disc_artist="" -metadata disc_album="" -metadata disc_genre="" -metadata disc_date="" -metadata synopsis="" -metadata encoder="" -metadata ldes="" "$output_file"
            echo "Metadata removed from $file and saved as $output_file"
            ;;
        *)
            echo "Unsupported file type: $file"
            ;;
    esac
done
