# Video to GIF
Turn any video into a clean, smooth GIF with a single bash command.

## Prerequisites
- `ffmpeg` and `ffprobe` available in `PATH`. Install via your package manager (e.g., `brew install ffmpeg` on macOS).
- Bash shell (script tested with `bash`).

## Usage
```bash
./video_to_gif.sh /path/to/video.mp4 [output.gif]
```
- If `output.gif` is omitted, the script saves next to the input using the same base name (e.g., `video.mp4` → `video.gif`).
- The script will exit if the input file does not exist or ffmpeg/ffprobe are missing.

### Example
Convert `clips/dance.mov` to a GIF in the same folder:
```bash
./video_to_gif.sh clips/dance.mov
# Creates: clips/dance.gif
```

Convert and specify a custom output path:
```bash
./video_to_gif.sh clips/dance.mov ~/Desktop/dance_small.gif
```

## What the script does
- Detects the exact frame rate of the source video to keep motion smooth.
- Generates an optimized color palette, then applies it for cleaner GIF output.
- Uses Lanczos scaling; width is preserved and height auto-adjusts to maintain aspect ratio.

## Tips
- Trim your video before conversion for smaller GIFs.
- For very large inputs, consider resizing first in your video editor to reduce file size.
