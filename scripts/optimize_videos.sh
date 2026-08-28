#!/usr/bin/env bash
# Compress demo videos for faster progressive playback (especially on mobile).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT/web/content"
OUT_DIR="$ROOT/web/content/optimized"
mkdir -p "$OUT_DIR"

if command -v ffmpeg >/dev/null 2>&1; then
  FFMPEG=(ffmpeg)
elif [[ -x "$ROOT/tools/ffmpeg" ]]; then
  FFMPEG=("$ROOT/tools/ffmpeg")
elif command -v docker >/dev/null 2>&1; then
  FFMPEG=(docker run --rm -v "$SRC_DIR:/in:ro" -v "$OUT_DIR:/out" jrottenberg/ffmpeg:6-alpine)
  USE_DOCKER=1
else
  echo "ffmpeg not found (install ffmpeg, Docker, or run tools/ffmpeg setup)." >&2
  exit 1
fi

slugify() {
  local name="$1"
  name="${name%.*}"
  name="$(echo "$name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
  echo "$name"
}

encode() {
  local input="$1"
  local output="$2"
  local max_width="$3"
  local crf="$4"
  local fps="$5"
  local in_name
  in_name="$(basename "$input")"
  local out_name
  out_name="$(basename "$output")"

  if [[ -f "$output" ]] && [[ "$output" -nt "$input" ]]; then
    echo "skip $out_name (up to date)"
    return
  fi

  echo "encode $in_name -> $out_name (${max_width}px, crf ${crf})"
  if [[ "${USE_DOCKER:-0}" == "1" ]]; then
    "${FFMPEG[@]}" -hide_banner -loglevel error -y \
      -i "/in/$in_name" \
      -vf "scale='min(${max_width},iw)':-2" \
      -c:v libx264 -preset medium -crf "$crf" \
      -movflags +faststart -an -r "$fps" \
      "/out/$out_name"
  else
    "${FFMPEG[@]}" -hide_banner -loglevel error -y \
      -i "$input" \
      -vf "scale='min(${max_width},iw)':-2" \
      -c:v libx264 -preset medium -crf "$crf" \
      -movflags +faststart -an -r "$fps" \
      "$output"
  fi
}

shopt -s nullglob
for input in "$SRC_DIR"/*.{mp4,webm,MP4,WEBM}; do
  [[ -f "$input" ]] || continue
  base="$(slugify "$(basename "$input")")"
  encode "$input" "$OUT_DIR/${base}.mp4" 960 28 24
  encode "$input" "$OUT_DIR/${base}-mobile.mp4" 480 32 20
done

echo "Optimized videos in $OUT_DIR"
du -sh "$OUT_DIR"/* | sort -h
