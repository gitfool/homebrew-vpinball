# Homebrew Tap for Virtual Pinball

[![License](https://img.shields.io/github/license/gitfool/homebrew-vpinball?color=blue&label=License&logo=github)](LICENSE)
[![GitHub Actions](https://img.shields.io/github/actions/workflow/status/gitfool/homebrew-vpinball/bump.yaml?branch=main&label=GitHub%20Actions&logo=github)](https://github.com/gitfool/homebrew-vpinball/actions)

## How do I install apps?

* Install [brew](https://brew.sh) ([FAQ](https://docs.brew.sh/FAQ)) using a non-root shell:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

* Add brew [tap](https://docs.brew.sh/Taps):
```sh
brew tap gitfool/vpinball
```

* Install apps via brew [cli](https://docs.brew.sh/Manpage):

| Name | Description | Command | Version |
| --- | --- | --- | --- |
| [vpinball](https://github.com/vpinball/vpinball) | Visual Pinball BGFX<sup>1</sup> | `brew install vpinball` | [![Version](https://img.shields.io/badge/dynamic/regex?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgitfool%2Fhomebrew-vpinball%2Frefs%2Fheads%2Fmain%2FCasks%2Fvpinball.rb&search=version%20%22(.%2B)%22&replace=v%241&label=&logo=homebrew)](Casks/vpinball.rb) |
| [vpinball-nightly](https://nightly.link/vpinball/vpinball/workflows/vpinball/master?preview) | Visual Pinball BGFX<sup>1</sup> nightly<sup>2</sup> | `brew install vpinball-nightly` | [![Version](https://img.shields.io/badge/dynamic/regex?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgitfool%2Fhomebrew-vpinball%2Frefs%2Fheads%2Fmain%2FCasks%2Fvpinball-nightly.rb&search=version%20%22(.%2B)%22&replace=v%241&label=&logo=homebrew)](Casks/vpinball-nightly.rb) |
| [vpxtool](https://github.com/francisdb/vpxtool) | Terminal based frontend and utilities for Visual Pinball | `brew install vpxtool` | [![Version](https://img.shields.io/badge/dynamic/regex?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgitfool%2Fhomebrew-vpinball%2Frefs%2Fheads%2Fmain%2FCasks%2Fvpxtool.rb&search=version%20%22(.%2B)%22&replace=v%241&label=&logo=homebrew)](Casks/vpxtool.rb) |

<sup>1</sup> [BGFX](https://github.com/dekay/vpinball-wiki/wiki/About-Visual-Pinball#bgfx) x64 release only

<sup>2</sup> Requires GitHub login

## How do I update apps?

* Update brew and apps
```sh
brew update && brew upgrade && brew cleanup --scrub
```
