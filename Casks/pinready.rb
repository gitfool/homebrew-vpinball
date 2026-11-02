cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.23.2"
  sha256 arm:          "c5f19083244659eed3d5a9c030c2033f034a243dc13730cd5b1bdd83786eeefd",
         intel:        "80edf8b3cf6681bea0da3ffb36270d15b99dd618b8c464de61eb06f5a1e3a51a",
         arm64_linux:  "4e248f3d04dc02d9d48e31bc27e3925555c13ff475274a118f073cb862afbc84",
         x86_64_linux: "e68f69ca0ff3d9e85edc5a4b0ddcf4616b5711ee5baa06814054f7bf700f3b9b"

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
