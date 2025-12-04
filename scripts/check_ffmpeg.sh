#!/usr/bin/env bash
set -euo pipefail

have_ffmpeg=0
have_ffprobe=0

if command -v ffmpeg >/dev/null 2>&1; then
  have_ffmpeg=1
fi

if command -v ffprobe >/dev/null 2>&1; then
  have_ffprobe=1
fi

if [[ $have_ffmpeg -eq 1 && $have_ffprobe -eq 1 ]]; then
  echo "ffmpeg and ffprobe are installed and on PATH."
  exit 0
fi

echo "ffmpeg and/or ffprobe not found."
echo

os=$(uname -s 2>/dev/null || echo unknown)
case "$os" in
  Darwin)
    cat <<'EOS'
macOS install options:
- Homebrew: brew install ffmpeg
- No Homebrew: download a macOS build (evermeet.cx or gyan.dev) and place ffmpeg/ffprobe on your PATH (e.g., /usr/local/bin or /opt/homebrew/bin).
EOS
    ;;
  Linux)
    cat <<'EOS'
Linux install options:
- Debian/Ubuntu: sudo apt-get update && sudo apt-get install ffmpeg
- Fedora/RHEL/CentOS: sudo dnf install ffmpeg (or sudo yum install ffmpeg on older releases)
- Arch: sudo pacman -S ffmpeg
EOS
    ;;
  MINGW*|MSYS*|CYGWIN*)
    cat <<'EOS'
Windows install options:
- Download the "release full" zip from gyan.dev (FFmpeg builds)
- Unzip to C:\ffmpeg and add C:\ffmpeg\bin to your PATH
- Open a new terminal, then re-run this script or ffmpeg -version
EOS
    ;;
  *)
    cat <<'EOS'
Install ffmpeg and ffprobe using your OS package manager or official builds, then ensure both are on PATH.
EOS
    ;;
esac

exit 1
