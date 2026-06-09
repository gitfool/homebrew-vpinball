cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.3"
  sha256 arm:          "04fb7513f75a6af5933fc58f429cc462a903d55ae2e85fb87c590d3a3822b509",
         intel:        "5826d43e94835427592f0088e6830ff02294750363760f9705289d9ebd8bd0f6",
         arm64_linux:  "69b676a994026b8580503d4d69e472c446c81bbe1e0359f28cf9d4ea8efc042c",
         x86_64_linux: "49107d2124289a4f79ba17b1d0591cbd8fac16280cdbc7324c731905e55ff5c7"

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
