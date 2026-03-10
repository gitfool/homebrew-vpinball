cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macOS", linux: "Linux"

  musl = on_system_conditional macos: "", linux: "-musl"

  version "0.26.1"
  sha256 arm:          "7aac2490a0091fb0a5b287dd74014a8eae75c51bf143593235bb09b8396ecbe8",
         intel:        "6056a9ba8d54146cd3eb0380c7decf924900e2c6fb3f12267577df8c0463547d",
         arm64_linux:  "ddb3bf46a562e81fab56dcd1aa613b692302cc6c2fb03fa51646a9006c3db085",
         x86_64_linux: "2fa2a869147e7edc7dd20615379594eece2074dfd3cc4616f34b12145f3dc526"

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}#{musl}-v#{version}.tar.gz"
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
