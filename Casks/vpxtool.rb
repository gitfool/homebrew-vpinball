cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.32.0"
  sha256 arm:          "1d9678aee640568a5e75e3966d3d1f88f7602bec2f30d93e3429b8c47f0916de",
         intel:        "0a88cea9254e96a287d56b3b0e32da1064f85695f35df690512a8fb1db079d60",
         arm64_linux:  "6ec9bb728e93cdfabc1ca0b35316715a94954330d85ca49149a09b827cd0adaa",
         x86_64_linux: "84ae67111bd646c0f655322679993999edbb47c9e123a7ee4160c0c47b1502fd"

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
    end
  end

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
