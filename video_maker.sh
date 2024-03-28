#!/bin/bash

# Checks for ffmpeg installation
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg could not be found, please install ffmpeg to use this script."
    exit 1
fi

# Displays usage information
display_usage() {
    echo "Usage: $0 [-del] [-crf value] input_file"
    echo "  -del          Delete the original file after processing."
    echo "  -crf value    Set the CRF value for encoding (default is 28)."
    echo "  input_file    Specify the input video file to be processed."
    exit 2
}

# Default parameters
delete_original=0
crf_value=28

# Parse command-line arguments
while getopts ":delcrf:" option; do
  case $option in
    del)
      delete_original=1
      ;;
    crf)
      crf_value=$OPTARG
      ;;
    \?)
      display_usage
      ;;
  esac
done
shift $((OPTIND-1))

# Validates there's exactly one input file
if [ $# -ne 1 ]; then
    display_usage
fi

input_file="$1"
if [ ! -f "$input_file" ]; then
    echo "Input file does not exist."
    exit 1
fi

# Compresses and resizes the video
compress_video() {
    local input_file=$1
    local output_file=$2
    local target_width=$3
    ffmpeg -i "$input_file" -c:v libx265 -crf "$crf_value" -vf "scale=$target_width:-2" "$output_file"
}

# Retrieve original video resolution
resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input_file")
width=$(echo $resolution | cut -d'x' -f1)

# Array of target widths
declare -a target_widths=("3840" "2560" "1920" "1280" "640")

# Create copies based on resolution dynamically
for target_width in "${target_widths[@]}"; do
    if [ "$width" -ge "$target_width" ]; then
        case "$target_width" in
            3840) label="2160p";;
            2560) label="1440p";;
            1920) label="1080p";;
            1280) label="720p";;
            640) label="360p";;
        esac
        output_file="${input_file%.*}_${label}.mp4"
        compress_video "$input_file" "$output_file" "$target_width"
    fi
done

# Optionally delete the original video
if [ "$delete_original" -eq 1 ]; then
    rm "$input_file"
fi
