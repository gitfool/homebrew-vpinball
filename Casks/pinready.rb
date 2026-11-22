cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.0"
  sha256 arm:          "23841d41e9fc3e86f258823cfa8ea30f39b89a1f5c463d5683ae7a142dad0b98",
         intel:        "aa3a74aa527e03f1dcd9ec82a2fddf94412ffb62e2468bd6a8419f6532f46358",
         arm64_linux:  "6c1f903a6b0da8658d92e32fc2dd8965f9ce0dea6f836f1ee23387abee286db5",
         x86_64_linux: "916285040ce418fd7d2ba96fa3229b3ce0913a627e9c9e639410b0c66ca3a374"

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
