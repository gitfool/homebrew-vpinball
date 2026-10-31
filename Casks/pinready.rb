cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.23.1"
  sha256 arm:          "abb59b3c4cd1290b69db0fbcdec9c6df8c0ddc2832a095dd315e5b5a181affbc",
         intel:        "a1ecaf121a52c62e80640a8ca1300eb9111d12349d53a52969224734643c00fe",
         arm64_linux:  "ded92580bdeab3669b37c576f8e52f718c888fe6a4b3b5747da0ba7ce4ad73bb",
         x86_64_linux: "b6333dd1c7f1a80de770ef8fd76cf4d0cc27641dbe531b01cec445b0d6990bb3"

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
