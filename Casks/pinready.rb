cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.28.1"
  sha256 arm:          "ac30f3e5f822d63247ffcc0b63772e2ec37c0594100b1cc7e431d29f3edf5d21",
         intel:        "e9444afec0991c2f4a2bba7dc71353d9bc78cb15d742236c28f4d4d7c48f63a8",
         arm64_linux:  "61c70a352b2336352983a3f15dcb789707f1bf8b449f1094a1ed79aa28202047",
         x86_64_linux: "d519947b295f412479bcffd24d4f49c8bb79e50121276f82c4a0de3dd01b8a23"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/pinready"]
    end
  end

  url "https://github.com/Le-Syl21/PinReady/releases/download/v#{version}/pinready-#{os}-#{arch}.tar.gz"
  name "pinready"
  desc "Cross-platform configurator and launcher for Visual Pinball"
  homepage "https://github.com/Le-Syl21/PinReady"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "pinready"

  zap trash: [
    "~/.local/share/pinready",
    "~/Library/Application Support/pinready",
  ]
end
