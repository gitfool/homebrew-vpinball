cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.36.0"
  sha256 arm:          "c06ba7197c89fc66c2e21eb1bb15a89604b9dd43aef223d9d09b909cc54f798b",
         intel:        "7d2de71cde992322ababc54f76d75fd17c3020b8220bc5b65667eda0348063ac",
         arm64_linux:  "d888e1f8d0a343999e7af0db1fbcc590e73ed8b2e0d933388f0dd6b1e38c2ad9",
         x86_64_linux: "4bca2c57b5324177df8531c79da416595d61590bbc29b5466636fb22a34f67ce"

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
