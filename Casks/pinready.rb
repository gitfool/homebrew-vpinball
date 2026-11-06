cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.24.0"
  sha256 arm:          "997a82d6be985faeced6308d5c0af766c56e9dd3f3061601e17dd1ba9bbb7243",
         intel:        "555fb6b7cc2a00fa86128c1cf54f61249013a5ad978dddd0bc411f851ada2163",
         arm64_linux:  "1079a366fffcdb3db2fee19eb26928e594ef09551765a441043302d9cd565894",
         x86_64_linux: "310c1ba264f30b4aef9e4b1acad1f162289e4d5fe22ed55a0eb780ed94465a71"

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
