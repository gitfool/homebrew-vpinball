cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.0"
  sha256 arm:          "cfb023177f6930fa90b6343c774fdfa3563b3b244079f3f6d01bcdb832963099",
         intel:        "aecce03f240aaf6629b0d27d9d90e474f5c2b64feb387b492d35cbdda554b464",
         arm64_linux:  "3e7892c41187d6074eb50bb6c5615e35bded1a59c25846f47f9403fc854702f8",
         x86_64_linux: "bd2964edc01496f69bdc5e024f1d68a6068ccdbc43acbec5ad0090e60f7af868"

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
