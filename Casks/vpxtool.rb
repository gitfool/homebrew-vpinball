cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.26.2"
  sha256 arm:          "b7642d7aabd1c201be46d030c0cd1ff85f59bde167113291097a7f377bf48780",
         intel:        "53b54165ee0cf3022d4ed9f4b8b18ee8e9d9d495a218c1654f49f4ca58a7cb4d",
         arm64_linux:  "9e6119b122733bda36814680426cd00e54a5f7cb67196a53a23bb45817c2980d",
         x86_64_linux: "1b7432ff198c918197b5177cf47a7831436d6f843700423b2ce0722e1c15ec9d"

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
