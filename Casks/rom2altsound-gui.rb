cask "rom2altsound-gui" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "zip", linux: "tar.gz"

  version "0.7.0"
  sha256 arm:          "7c13962fb4d5bad0b5b1897be616328d6b18de335c39466a0a60d0cd39690822",
         intel:        "9207761d5100203ed1c2da49a7e75a5556a03e6cca2608f8f2615821c563bfb5",
         arm64_linux:  "24ca91a3fc2f3d09e409da2ebbbf8420e5ab14899814c9dfeb9aff2f1ed35486",
         x86_64_linux: "2a6175a059ffcc14e46258affdb29499efd3201ffc93990acddd046ff09d687d"

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
