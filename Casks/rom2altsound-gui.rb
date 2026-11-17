cask "rom2altsound-gui" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "zip", linux: "tar.gz"

  version "0.6.0"
  sha256 arm:          "b94c02d0f05f9999cd702970301f3f3ba33c3abc65870db9a9d951947875bbb9",
         intel:        "3bc34115ab394207e3444f999a7eec3b749ebff01d61f3b0f20d609fb9d5ec9b",
         arm64_linux:  "94ecf9381acc68cc4c2e2879d9cc0e069ae9da7a3fcd92eb179aecc253a58849",
         x86_64_linux: "174b2decd001c91838acefc0200a4fc36887e0e75e0f14067f7e818868fdccc0"

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
