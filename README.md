# smiley.sh

[Demo](https://smileyface.ga)

## Overview

smiley.sh is a very fast SSG script written in bash with GitHub Actions support.

This script is useful for bloggers who want a minimal blog with very little setup.

## Installation

### Local Installation

Useful for quick testing and theme/module development for `smiley.sh`

#### Create required files.

Download the sample project structure from [smiley-empty-project](https://github.com/ParaSpl01t/smiley-empty-project.git)

```sh
git clone https://github.com/ParaSpl01t/smiley-empty-project.git
```

#### Download the latest script in the project folder.

```sh
cd smiley-empty-project
```

```sh
curl https://raw.githubusercontent.com/ParaSpl01t/smiley.sh/main/smiley.sh
```

#### Run the script

```sh
bash smiley.sh
```

The built site will be saved in `docs/` directory.

---

### GitHub Actions

Useful for quick deployment.

#### Create required files.

Download the sample project structure from [smiley-empty-project](https://github.com/ParaSpl01t/smiley-empty-project.git)

```sh
git clone https://github.com/ParaSpl01t/smiley-empty-project.git
```

#### Create a worlflow file in project folder.

```sh
cd smiley-empty-project
```

```sh
touch .github/workflows/build-blog.yml
```

contents of `.github/workflows/build-blog.yml` :

```yaml
name: Build blog
on: [push]
jobs:
    Build-Blog:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v2
            - uses: ParaSpl01t/smiley.sh@v0.0.1
```

#### Make changes to src

Edit `src/0000-first-post.html` file or create a new file in `src` directory. The name of the file doesn't matter but the contents do.

Now push to github and done.
