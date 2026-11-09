cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.40.0"
  sha256 arm:          "9a74b29788aaeee43cac1b89d9bb0a2f362a0477b3494adda566057e48369107",
         intel:        "cb965e93d41ace8fac0ce732367ba26849c3421055f3c9369be2ea5bf63474de",
         arm64_linux:  "c1e526291fea5ff9e53f1041004d556de902ed83268af10657d4c3b2c49b1811",
         x86_64_linux: "2af92aba380598818598ddf13a4f911ee0f01e65261fa2bc9536c5d85a7d8736"

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
