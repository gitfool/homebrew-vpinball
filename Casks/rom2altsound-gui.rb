cask "rom2altsound-gui" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "zip", linux: "tar.gz"

  version "0.2.6"
  sha256 arm:          "83211cab913dd7e3f1156c8a7923d4ab301825d0ce9c153543c87556e1ea0be9",
         intel:        "9431a5a8383f35d8014f9a9c3e1c19011a5492f7ccf49a30fe9fc25cd58ee07c",
         arm64_linux:  "61b020879b1cc3c1c1dda4f607637b16bd9a7932e22d66a2e5828b920d1071b2",
         x86_64_linux: "30ed93dc59dc9eced5599b7775a5fc40f0e4c5862e1f082390a7d93d01de83e8"

  on_macos do
    arch arm: "arm64", intel: "x86_64"

    app "rom2altsound.app"
    binary "#{appdir}/rom2altsound.app/Contents/MacOS/rom2altsound-gui", target: "rom2altsound-gui"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/rom2altsound.app"]
    end
  end
  on_linux do
    arch arm: "aarch64", intel: "x86_64"

    binary "rom2altsound-gui"
  end

  url "https://github.com/Le-Syl21/rom2altsound/releases/download/v#{version}/rom2altsound-gui-#{os}-#{arch}.#{ext}"
  name "rom2altsound GUI"
  desc "Extract every sound of a PinMAME ROM for AltSound (GUI)"
  homepage "https://github.com/Le-Syl21/rom2altsound"

  livecheck do
    url :url
    strategy :github_latest
  end

  zap trash: [
    "~/.cache/rom2altsound",
    "~/Library/Caches/rom2altsound",
  ]
end
