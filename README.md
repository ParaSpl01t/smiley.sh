# smiley.sh

## Overview

smiley.sh is a very fast SSG script written in bash with GitHub Actions support.

This script is useful for bloggers who want a minimal blog with very little setup.

## Installation

### Local Installation

Useful for quick testing and theme/module development for `smiley.sh`

#### Download the latest script.

```sh
curl https://raw.githubusercontent.com/ParaSpl01t/smiley.sh/main/smiley.sh
```

#### Create required files.

Project Structure.

```
project/
├─ src/
│  ├─ 001-first-post.html
│  └─ 002-second-post.html
├─ theme/
│  ├─ root/
│  │  └─ index.css
│  ├─ card.html
│  ├─ index.html
│  └─ post.html
├─ smiley.config
└─ smiley.sh
```

#### Run the script

```
bash smiley.sh
```

The built site will be saved in `docs/` directory.
