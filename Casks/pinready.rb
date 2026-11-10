cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.2"
  sha256 arm:          "ac87352dcd33f0924e5fb835b1c19c5009e5d109184d82cb6b03e69b439f3999",
         intel:        "04e8fba330c7a7dd3b73ee3cc2f1fe9ff56b4b4063ac7ecbbc9607c967011f90",
         arm64_linux:  "8021d95a10e0d05e7964396dbfeb712dba644f4c32cfbcd436415f930ae03487",
         x86_64_linux: "5bfa9c36ad76afddaa6e32f17efdf594ace697ceabd4d8b9d1810ba56bb3b021"

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
