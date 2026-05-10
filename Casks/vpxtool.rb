cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.30.0"
  sha256 arm:          "18bca7536f640f1aabd67d46d557a76fbbad86c0ee980a980820b21132a31b42",
         intel:        "4d4a15745adae68e1331d25805e8f7b1cad22e861af3f9d9e8eccb80c7ff929b",
         arm64_linux:  "3987e32681fc18a806eb465d94b63ae4ee261d4acd5807729f5bcf1b829b4618",
         x86_64_linux: "6e302f9b3aaff61ef0a3c17c2c58ec9b1b8fd763c96b137c812922475c702514"

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
    end
  end

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
