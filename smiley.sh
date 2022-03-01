#!/bin/bash

# Check and load config file
CONFIG=smiley.config
if [ -f "$CONFIG" ]; then
    . $CONFIG
fi

# Preprations before building
[ ! -d "tmp" ] && mkdir tmp # make tmp directory (if not exist) for tmp shit
[ "$backupGit" = "true" ] && cp -r docs/.git* tmp/  # copy docs/.git* to tmp if backupGit is true in config
[ -d "docs" ] && find docs -mindepth 1 -delete || mkdir docs # Create/Empty docs directory

# Get yaml value from key. ARGS- $1: file name, $2: yaml key name
getprop () {
	local F=$(cat $1) # File contents
	local Y=$(echo "$F" | sed -n '1,/---/p') # metadata section from file
	local L=$(echo "$Y" | sed -n "/^$2/p" ) # Line with the required key:value pair
	echo $L | sed "0,/$2:\ /s///" # echo line without the  "key:" part
}

# Get all the lines except yaml matadata from file. ARGS- $1: file name
getpost () {
	local line=$(sed -e '1,8d' < $1)
	echo "$line"
}

# Loop goes Brrrrrr..
for FILE in src/*;
do
	# Parse metadata form post. $FILE is path to current post in src/ directory
	title=$(getprop $FILE "title")
	desc=$(getprop $FILE "desc")
	slug=$(getprop $FILE "slug")
	author=$(getprop $FILE "author")
	created=$(getprop $FILE "created")
	updated=$(getprop $FILE "updated")

	post=$(getpostn $FILE) # Post content
	
	# Load post template
	posttemplate=$(cat theme/post.html)

	# Start populating the template
	finalpost=${posttemplate//\:\(title\)/$title}
	finalpost=${finalpost//\:\(post\)/$post}
	finalpost=${finalpost//\:\(desc\)/$desc}

	# Put the finalpost in correct file
	mkdir docs/$slug
	echo "$finalpost" > docs/$slug/index.html
	
	# Append part of post metadata to $POSTS variable
	# This makes a table with ";" delimeter and "\n" as line seperator
	# $created is the first column so it will be used for sorting
	POSTS="$POSTS$created;$title;$slug;$desc\n"
done

# Sort $POSTS by created timestamp
POSTS=$(echo -e "$POSTS" | sort -t \; -r )
POSTCOUNT=$(echo "$POSTS"  | wc -l)

# haha second loop goes brrrrrrrrrr....
for ((i = 1 ; i <= $POSTCOUNT ; i++)); do
	# Load current post metadata
	postmeta=$(echo "$POSTS" | sed -n "$i"p)

	# convert data from $postmeta into an array $a
	readarray -td\; a <<<"$postmeta"

	# Load card template
	cardtemplate=$(cat theme/card.html)
	
	# Start populating the card template
	finalcard=${cardtemplate//\:\(title\)/${a[1]}}
	finalcard=${finalcard//\:\(desc\)/${a[3]}}
	finalcard=${finalcard//\:\(slug\)/${a[2]}}
	finalcard=${finalcard//\:\(created\)/${a[0]}}

	# append current card to global $CARDS
	CARDS="$CARDS$finalcard\n"
done

# Populate index with data from $CARDS and save to docs/index.html
FINALCARDS=$(echo -e "$CARDS")
indextemplate=$(cat theme/index.html)
finalindex=${indextemplate//\:\(cards\)/$FINALCARDS}
echo "$finalindex" > docs/index.html

# copy static data to docs/ root
cp -r theme/root/* docs/

# Cleanup and after-build tasks
[ "$backupGit" = "true" ] && cp -rT tmp/ docs/ # copy tmp/.git* to docs if backupGit is true in config
find tmp -mindepth 1 -delete # empty tmp/ directory
