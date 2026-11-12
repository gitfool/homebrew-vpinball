cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.5"
  sha256 arm:          "8765aa8c98c59b30d314520b2b707924d7f6b8b956d5607d9911e7c8d7ba63e1",
         intel:        "66d3f68c1c812926bb01b2dd2a3f349a327c18d3d2e7d736186d2760d8fc501c",
         arm64_linux:  "e44f1404e204d223f489bc739a11c6a314364e2aed817a184a48541440dea7ec",
         x86_64_linux: "b51f0c73a4f752742025177883e265856179494b11c2469156cf564b5b730e1d"

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
