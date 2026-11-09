cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.25.0"
  sha256 arm:          "7911e793e7cd10d791b2cdc261e516bcabbee6bfe74c7db40bb5195ea7c01a27",
         intel:        "9419e52cbc732ba297e5b3c6d7b8ab44e1c90ae209f10fb1e089dfe76a489563",
         arm64_linux:  "c703f8514b34096a825c5d417a6bb4b7c75be502247e9f925f1d54169f6493b2",
         x86_64_linux: "864ef28934b7bc0fec4f4542113d34a28992d64abeba1af1e8eecb54603f94dc"

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
