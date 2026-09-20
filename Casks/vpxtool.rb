cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.4"
  sha256 arm:          "36dc54ec2898804cf2d65899834ba5a0e5a0bd77a5ab1b810ff8a461fc1d6081",
         intel:        "beddf1e03cee8cdcc86d6b178a9c46f41c5435a5e8c0e6d913727015966469e8",
         arm64_linux:  "dbd756c3be99bf8a10d97608d958c19b08db8519953beb3048f514d40b032b01",
         x86_64_linux: "fb367d4dd1d35c057f642729c952506d61797767f8ada443893838a2dd68701f"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/vpxtool"]
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
