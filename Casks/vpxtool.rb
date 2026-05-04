cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.1"
  sha256 arm:          "3bbfee931939e9078e0cfa4f2cc1a880620fcc54559fc30929dfffeeda22bff3",
         intel:        "7f8fcf6b34a69e8dc445a908da47c4e84698755743296d62f1b9792dd1eb9c3a",
         arm64_linux:  "4f7b512fe34f56128c8c8cdec1f804a3c3368a0fbda26dbfa61c0d69ce7aabc0",
         x86_64_linux: "c033de39dedbfbf7e64ad90cd4612ddfcfebd1bfd8306f80015011b378eb8ace"

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
