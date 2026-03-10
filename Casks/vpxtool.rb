cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macOS", linux: "Linux"

  musl = on_system_conditional macos: "", linux: "-musl"

  version "0.25.0"
  sha256 arm:          "b7e6d380c9145e8974c82ae7de4072916106909c0408948f1aa74a4df7d58f17",
         intel:        "c30ff47364b4249bd10d5e8966bea3f613a572c7b49b4bbcfd5f1991d4bf3a43",
         arm64_linux:  "ec8bef31f7e23ae9f6324355e23de8a83830d037b9c5e799637627ee60308056",
         x86_64_linux: "d88b77861c7cb7a4e0204a5356ac9a3994a23bc2b6d09d1d8622d22e9d3a1eac"

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
