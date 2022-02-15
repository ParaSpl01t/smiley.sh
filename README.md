# smiley.sh

A very fast SSG script written in bash with GitHub Actions support.

## Installation

### Local Installation

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
