cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.9"
  sha256 arm:          "2f1d7e86c846f366ccd1786d29f37b014c4c9778bcc611652834174d2967505f",
         intel:        "3460beba4f4d136db2a3fa25dfd778c4685a7b7735f90f840de3ab2f1e8f3710",
         arm64_linux:  "0b470a669448be9d5a88ac1ffd7ec1ea075655714fffa1f749ce0389b952e5e4",
         x86_64_linux: "5aa3ea943429e6d20e5fe4b870b541652a3bca93d610d8922f47038220d621c6"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
    end
  end

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
