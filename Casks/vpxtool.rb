cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.4"
  sha256 arm:          "97033b51c8b4b71ed5e82dffdbab7ff5e9c097d9645c6dedcd2e9f3fb75641fe",
         intel:        "ab460ad381c27a929d8fc556a196a5de5ea11838f9ae4293c241c97ded6b1be3",
         arm64_linux:  "d1fede5a052e7e7c580587c3d46655157f2f5c6d8f83dd5f0c5605f0727f84b0",
         x86_64_linux: "7423a5aa2925f8997eaa50877a0d1dc1931c10ed3234a7d81b0419512b5998b4"

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
