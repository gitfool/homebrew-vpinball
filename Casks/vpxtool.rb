cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.35.0"
  sha256 arm:          "051919d48273d1f9732c1b794c9740f0c72148ea1c59dbc7c125a0217ac57b31",
         intel:        "d54cd6d1dc8a0dd1bc749ccfb30c4d2de8b3f29c083d83eea53ba4d2b0e87c3c",
         arm64_linux:  "cc7ab4e0f09fb2c8be949a81f4f0e44d470ced36191fbe6ca66d6b612d07f945",
         x86_64_linux: "42b7bbd5a596f6637051b22ef0ddf5c47ae8754fdd506e4ef7a38657a2469e62"

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
