cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.0"
  sha256 arm:          "07d3f7ab968f6ad25e94e841990406f2b236f6743bc35f7b483b8e43bfdadfe5",
         intel:        "19581a3a68c6ba2131d5d49eaaa67fb5c3ef33b2fe82f18927715ff2dbf0e60b",
         arm64_linux:  "27928ea948f44dea1140b12ae0fcc0544e60ab05012088ec73a7a8b7c10ece90",
         x86_64_linux: "afd778b3e320795a21876944fdce32a2f9ba891542912524dd75dcdb7a71446f"

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
