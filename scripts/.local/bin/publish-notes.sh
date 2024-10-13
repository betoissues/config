#! /bin/bash

VAULT_PATH="$HOME/Common/Notes"

DEST_PATH="$HOME/src/notes"

FLAGS="--only-tags published --frontmatter always --start-at"


set -x

cd $DEST_PATH

obsidian-export $VAULT_PATH $FLAGS $VAULT_PATH/07\ Wiki $DEST_PATH/content &&

hugo convert toTOML --logLevel debug --unsafe

# required to fix some footnotes issues
#find . -type f -name "*.md" -exec sed -i '' -e 's/^[ \t]*\(\[^[0-9]]:.*$\)/\1/' {} \;
find . -type f -name "*.md" -exec sed -i -e 's/^[ \t]*\(\[^[0-9]]:.*$\)/\1/' {} \;
