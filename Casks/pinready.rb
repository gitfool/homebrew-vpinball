cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.31.1"
  sha256 arm:          "c873639e6840689c50ec9dedce39fdb6232e4a163e0a50e101dc356e48400ce0",
         intel:        "ff6588f353c8009cf1c19b4c1b8390693890692f0560517fac09d85e83522299",
         arm64_linux:  "5dec7d6241244d26561812108e7f2ca937a2a1884cea36f24d883399a4bb9c1d",
         x86_64_linux: "6637bcba188a14bc570f1551a4ece4390ae9d52bdaef22cb07b62c3c1a12e10a"

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
