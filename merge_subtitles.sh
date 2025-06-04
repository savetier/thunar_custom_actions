#!/bin/bash
for video_file in "$@"; do
    # Extract the base name of the video file
    base_name=$(basename "$video_file" .mkv)
    # Construct the subtitle file name
    subtitle_file="${base_name}.srt"

    # Check if the subtitle file exists
    if [ -f "$subtitle_file" ]; then
        # Construct the output file name
        output_file="${base_name}_with_subs.mkv"
        # Use mkvmerge to integrate the subtitle file into the MKV container
        mkvmerge -o "$output_file" "$video_file" "$subtitle_file"
        echo "Subtitles integrated into $output_file"
    else
        echo "Subtitle file $subtitle_file not found for $video_file"
    fi
done
