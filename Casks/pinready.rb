cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.0"
  sha256 arm:          "6b053a0468303f13c056300c4f81a8b08614456f6a2eaa1b9f339521fe5db758",
         intel:        "e3c5d7431300b9ec176e0fc0df82cda2deed83b394e377ff7ac738708027cf10",
         arm64_linux:  "c68dc54fbe3f8ca643a739ff97fc4a65b6274ab57b60e70f5581f9f3e802b888",
         x86_64_linux: "b0c2a02740e4baa99fed377b1ddb896a95c580a9424cfbd29079bcf29e4aba7f"

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
