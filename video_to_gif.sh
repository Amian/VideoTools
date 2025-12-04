#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 /path/video.mp4 [output.gif]" >&2
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1 || ! command -v ffprobe >/dev/null 2>&1; then
  echo "Error: ffmpeg and ffprobe must be installed and available in PATH." >&2
  exit 1
fi

input="$1"
output="${2:-${input%.*}.gif}"

if [[ ! -f "$input" ]]; then
  echo "Error: input file '$input' not found." >&2
  exit 1
fi

# Extract the exact frame rate in rational form (e.g. 30000/1001) to keep motion smooth.
fps=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "$input")
fps=${fps:-30}

filter="fps=${fps},scale=iw:-1:flags=lanczos"
palette_file=$(mktemp "/tmp/ffmpeg_palette_XXXXXX.png")
trap 'rm -f "$palette_file"' EXIT

ffmpeg -y -i "$input" -vf "${filter},palettegen=stats_mode=full" "$palette_file"
ffmpeg -y -i "$input" -i "$palette_file" -lavfi "${filter}[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" "$output"

echo "Created: $output"
