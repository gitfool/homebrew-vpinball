cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.40.2"
  sha256 arm:          "2d223cef83e01f4517c55d7c24242a3b9f331498aa3c9364056c6698bd56071f",
         intel:        "27e7ba2458790ba92214f81c87f9d6395d7306d490029d825acff4835b48a8b7",
         arm64_linux:  "482778021cf1382852253cb7903a1e48cd97eb9c69bdc4ee14b7c270e7df7c92",
         x86_64_linux: "43a12fa67bbefb953eaa84da3d3c893e72e589d12a2dd7ae1daa131c227a9016"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/vpxtool"]
    end
  end

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
