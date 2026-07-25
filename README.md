# mktorrent Folder Batch

Create one torrent per immediate folder under one or more music roots. macOS, Windows, and Synology metadata files are excluded.

## Requirements

- Bash
- `mktorrent`

## Usage

```bash
chmod +x mktorrent_folder_batch.sh
./mktorrent_folder_batch.sh -a "https://tracker.example/announce" \
  "/Volumes/downloads/music_320" "/Volumes/downloads/music_v0"
```

Use `-o DIRECTORY` to store all generated torrents in a separate location. Existing torrent files are skipped. The tracker URL is supplied at runtime and is not stored in the repository.
