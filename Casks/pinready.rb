cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.13.10"
  sha256 arm:          "ba3a523aeee92fa646fd3ad05b6f18ee6cd1edd39bcb0ce03b57a4deea2eb995",
         intel:        "6e5031be28c6721153df7b36e54a87c05ba30c47f7bda62999f6278a961df1ee",
         arm64_linux:  "aa746e76474f5fce5b2d49253fd82d6c5b2ac26f0e94ce60524a7b79f9f8b4aa",
         x86_64_linux: "12e458c219c5aa04a0bb188011773865e257ef9fdae553667e1dfcb3864bd344"

  url "https://github.com/Le-Syl21/PinReady/releases/download/v#{version}/pinready-#{os}-#{arch}.tar.gz"
  name "pinready"
  desc "Cross-platform configurator and launcher for Visual Pinball"
  homepage "https://github.com/Le-Syl21/PinReady"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "pinready"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/pinready"]
    end
  end

  zap trash: [
    "~/.local/share/pinready",
    "~/Library/Application Support/pinready",
  ]
end
