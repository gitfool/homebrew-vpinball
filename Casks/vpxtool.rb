cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.39.0"
  sha256 arm:          "00369ea322e676e2336f128284f82706c8e82b949890b2973e76ce74309bcb84",
         intel:        "fff88dced81469c2044d9b08856e09eff16506509c2c2260178166b4f036b451",
         arm64_linux:  "76b2937df8addf156482967fac68e6a9197ac2b3f90f96b82f8f2f011aaf7aca",
         x86_64_linux: "76fecb6a65b88bf71ee1bce56322e19789d254f15a06284524c6cd85ed082dd9"

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
