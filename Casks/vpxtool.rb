cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.38.0"
  sha256 arm:          "062db5425ef7f7f2cd27e516573c3df8f279bf0a68a0084f8051cbf00f703244",
         intel:        "b16d4047183f3c333a11214758aa0adc7b23b7adc5a3aebd19f1dd8ced8c854f",
         arm64_linux:  "b76e251b46be429b29328cbe3697409c08d894b99c9fc25c16b7b925a9e17e10",
         x86_64_linux: "0e063b3c6b31a8cd9317079c9da53c9f439ea5cb257cc23e6da6ada1cfcffb27"

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
