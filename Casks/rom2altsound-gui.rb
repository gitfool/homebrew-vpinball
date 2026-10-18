cask "rom2altsound-gui" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "zip", linux: "tar.gz"

  version "0.4.0"
  sha256 arm:          "a4d5655cf076cdefe55cbc7995e8b85443553c9b1bad0a50996fa0521ae6c975",
         intel:        "1dc50a99a8ec87bf8fc0e3075473517c07a2f8d94a514d861f6ee017fe45a89c",
         arm64_linux:  "066794c41f6f44556c024fea73130efcc52069fa3c6ab685b73f05b0673113bb",
         x86_64_linux: "a3d0fecc9906170b9ffa2b69e5337923bd068f288710d225dc48ac98fcce85c2"

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
