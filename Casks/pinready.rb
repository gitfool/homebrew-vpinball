cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.5.6"
  sha256 arm:          "7f853379db696b807f048e9e3ae456b2d955c3cf9163723511c7748196f9b4e5",
         intel:        "6e0d48e46d5be9f4ea6ec112bd66fa27bd34824b2d16bddf58527f7a486807f4",
         arm64_linux:  "2477da3582e8cd2584d395aa51c73cdaa9d3fb7286aa62598faeff353420c731",
         x86_64_linux: "4b0da5bf39f9f1920e0c4b2e55205e57ce98dd6cdb1af09919d99776ffff4370"

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
