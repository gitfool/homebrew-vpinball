# Homebrew Tap for Virtual Pinball Tools

## How do I install these tools?

* Install [brew](https://brew.sh) ([FAQ](https://docs.brew.sh/FAQ)) using a non-root shell:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

* Add this brew [tap](https://docs.brew.sh/Taps):
```sh
brew tap gitfool/vpinball
```

* Install tools from this tap:

| Name | Description | Command |
| --- | --- | --- |
| [vpinball](https://github.com/vpinball/vpinball) | Visual Pinball BGFX<sup>1</sup> | `brew install --cask vpinball` |
| [vpinball-nightly](https://nightly.link/vpinball/vpinball/workflows/vpinball/master?preview) | Visual Pinball BGFX<sup>1</sup> nightly<sup>2</sup> | `brew install --cask vpinball-nightly` |
| [vpxtool](https://github.com/francisdb/vpxtool) | Terminal based frontend and utilities for Visual Pinball | `brew install --cask vpxtool` |

<sup>1</sup> [BGFX](https://github.com/dekay/vpinball-wiki/wiki/About-Visual-Pinball#bgfx) x64 release only

<sup>2</sup> Requires GitHub login

## How do I update these tools?

* Update brew and tools
```sh
brew update && brew upgrade && brew cleanup --scrub
```
