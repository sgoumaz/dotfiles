#!/bin/bash

pip install beets
# shouldn't be necessary apparently, but still had to reinstall this:
# pip install certifi
pip install "beets[fish,convert,musicbrainz,discogs,fetchart,lyrics]"
