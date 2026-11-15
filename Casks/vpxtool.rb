cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.40.1"
  sha256 arm:          "495ba04d6350a5ea903b339aa41ce34b86a9bfd33cced940b50762b6632b8445",
         intel:        "7fb64f991bc693fb842bdb9209eb99181d2d79282f8843a978d5eced4db8d8ca",
         arm64_linux:  "803ad5e0df3ca45d546a3b8511b0cd19682e0daef27b562a7e02fa984ed1d4b0",
         x86_64_linux: "4bb717c1f422ae742423ef1608b9ca913e5ae3ce06021910fe53b79137413f8b"

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
