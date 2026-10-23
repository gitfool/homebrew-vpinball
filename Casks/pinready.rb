cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.22.3"
  sha256 arm:          "2ae96fc74dd734b65daa3650d58dd3e3d1ac2dd6ab51713a84a19ebada995cc1",
         intel:        "c1e092ecd54cdeaae6ac00acc7f1b99612633e5026a17a8056825fb49390cbb1",
         arm64_linux:  "f74b5823721a796f4dc6df901cab1af5465a4401b3a4b1a634cd75c417b6341e",
         x86_64_linux: "9d218429b95fa9071c840c5608a92bc1546ad00449764c631b2522db523da7ac"

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
