cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.15.0"
  sha256 arm:          "d7114ac80d0cb03bdcdf559d3893f7ea6d1a7dcdc8f5236f790e53c44a6ce8ef",
         intel:        "544b14430aa3638fbe134ede3a6579f2ed75832414fd60776f3edfc9d1eeeebe",
         arm64_linux:  "a71615adcd51e7d8f50476241ac9c51fb0991a01a3cebf366eb03c8ec1713ebe",
         x86_64_linux: "bf3f3caabaed817bcfca9caac60864e284045b598ba63a859549038b1ec01aa2"

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
