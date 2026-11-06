cask "rom2altsound-gui" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "zip", linux: "tar.gz"

  version "0.5.0"
  sha256 arm:          "6ce9cb6d020fe2756994f37d36c7f54226ac5953a77e4320dc19bef59fdfb6e1",
         intel:        "f0309e9f89f3f055821610777716627f102bb8c5a6df08a4bd90d4f9d05f4d92",
         arm64_linux:  "07b21da3aeaac6aaa2587e86be5c137c0dc443e8b67048f76b231d9830269e73",
         x86_64_linux: "4b075cf6188b3a0f709c3ba83344261e52796b6fdd08bd74cc4404f791fb53bb"

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
