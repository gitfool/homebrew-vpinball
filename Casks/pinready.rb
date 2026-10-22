cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.22.1"
  sha256 arm:          "a1959248cf2e2de74c312ced004de06231579f7ce08e757c3edae7841a2c4caf",
         intel:        "a249ae0cccaf1bfd8b1fcccba680e66a08cd05145a5bb60ca5f14ffe03ad3e26",
         arm64_linux:  "354a4478eec0c7695305adfcb78b22ff1d7a5fcf72feb93475c97cce28ea577e",
         x86_64_linux: "bec83b6f3597586cddb3e1f00f5565924f2d1e3f590f1132da25087cbce5214b"

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
