cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.24.1"
  sha256 arm:          "a0058558d68b777cce35cab4b44726ac42ec55daf0602eaaf24472bf432ce788",
         intel:        "3953f11c7fb81d43100e0b2debf61d811520de2be5530590f005c5cd9667d4ae",
         arm64_linux:  "08b7963a29aab2dbf12c4abec79313463510473ded46b359f391f3a3b60fcbe7",
         x86_64_linux: "5b8393521e6aae9836749ccbbb2184acf110e598b2668c11be4f3d5c01a54a0f"

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
