# Video to GIF
Turn any video into a clean, smooth GIF with a single bash command.

## Prerequisites
- `ffmpeg` and `ffprobe` available in `PATH`.
- Bash shell (script tested with `bash`).

## Install FFmpeg and FFprobe
Check first:
```bash
ffmpeg -version && ffprobe -version
```
If both commands work, you are set. Otherwise:

- **macOS**: `brew install ffmpeg` (Homebrew). Without Homebrew, download a macOS build from evermeet.cx or gyan.dev and place `ffmpeg`/`ffprobe` somewhere on your `PATH` (e.g., `/usr/local/bin` or `/opt/homebrew/bin`).
- **Windows**: Download the "release full" zip from gyan.dev (FFmpeg builds), unzip to `C:\\ffmpeg`, and add `C:\\ffmpeg\\bin` to your `PATH`. Open a new terminal afterward.
- **Linux**:
  - Debian/Ubuntu: `sudo apt-get update && sudo apt-get install ffmpeg`
  - Fedora/RHEL/CentOS: `sudo dnf install ffmpeg` (or `sudo yum install ffmpeg` on older releases)
  - Arch: `sudo pacman -S ffmpeg`

After installing, re-run `ffmpeg -version` and `ffprobe -version` to confirm.

Optional: run `scripts/check_ffmpeg.sh` to see whether both tools are available and get OS-specific guidance.

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
