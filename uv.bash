#!/bin/bash

# networking & sync
uv tool install httpie # HTTP client (API testing etc.)

# media
uv tool install "beets[fish,convert,fromfilename,musicbrainz,discogs,fetchart,lyrics,info]"
# uv tool install yt-dlp # audio/video downloader

# other system utils
uv tool install visidata # tabular data explorer

# teaching
uv tool install copydetect # check code plagiarism based on code tokenization
