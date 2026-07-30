cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.7"
  sha256 arm:          "c9ed20cfa36b28c99875ebf3e469aa5363941f6536d535f94f76aac2d41588f4",
         intel:        "27b9c343107a9ce63933d8d3f68a25335a3b766dd5caecae88de4938d5dcd379",
         arm64_linux:  "9a2fa097e93ff473fb22bd52397cd868baa26a27b1cba0a34bb9c99d879dd081",
         x86_64_linux: "dc37536607eafb0b0965858c486972289542ef59db7f804e7d323a1b5388a1db"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
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
