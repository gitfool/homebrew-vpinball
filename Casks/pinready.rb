cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.10"
  sha256 arm:          "01f1060e15b3c7005a93a9e92a3dd3bed2b7612f0172d78f53686e3c091ae8bc",
         intel:        "97423948a2735dcfe055bf9ca97a2aa317d0fd218a1ae2a58229e607930bf8cc",
         arm64_linux:  "7c4827792dc67b799472b03ef30ab5103e0ac686dcfd1ee1e6bc1590facc3622",
         x86_64_linux: "1b56621cc61b72f8ee10dd52dd11a3eb05bfcf1447aa50a137dccd8cc957c1d7"

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
