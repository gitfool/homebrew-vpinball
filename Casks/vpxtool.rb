cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.3"
  sha256 arm:          "60876aa608ba9e00a9379dc2deeb166596ea6dfd9d1f427cf54ba01f7e8e0d5c",
         intel:        "65bd5508026547c9b3c9b0b991e1ceef74b093ae64c906f8c27aa8a365796901",
         arm64_linux:  "73a8083ef3f8e8bc6ecf4b5b765c1dcc73485f4bbf9066e99646fa862abab774",
         x86_64_linux: "0e57cef1fb0681eae078266c9e6fba7473afd9e992f739700f23d9cb1a491062"

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
