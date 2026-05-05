cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.2"
  sha256 arm:          "66e9e246cd86a56c05130134cb3ff8b33a8c50e69e4566439fb4b1e78902ca31",
         intel:        "4b6157af01bcee490d4faac11973ce749d97c12ef0b60b5a96465ad415268f8c",
         arm64_linux:  "933135a8d370554959a3a99e0725c1de013daae89c41cec84c8bb9d15e2dce87",
         x86_64_linux: "f150254758ee1f93d0981f754f1638ca3eedc407cd6c2748d018d8beaacd33a4"

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
