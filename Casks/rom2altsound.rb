cask "rom2altsound" do
  arch arm: (OS.mac? ? "arm64" : "aarch64"), intel: "x86_64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "tar.gz", linux: "tar.gz"

  version "0.2.6"
  sha256 arm:          "58287e44d1bd1885089ac4fc49313ad96908f4366d24c6b2c2abc2b52b13cb11",
         intel:        "a6aea32cfa069a4a8339950b5c762d4125ce1a2ebd5f6f0b5b25e67c3a73b02d",
         arm64_linux:  "3161f2a3e23612d07e67eacf3f426c68a2ee59db730b834fb5156d7731d48128",
         x86_64_linux: "d327f81dfdfcddc991f57edf99294fb02654d18e8ec55c228d0ac706d6ca7b02"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/rom2altsound"]
    end
  end

  url "https://github.com/Le-Syl21/rom2altsound/releases/download/v#{version}/rom2altsound-#{os}-#{arch}.#{ext}"
  name "rom2altsound"
  desc "Extract every sound of a PinMAME ROM for AltSound"
  homepage "https://github.com/Le-Syl21/rom2altsound"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "rom2altsound"

  zap trash: [
    "~/.cache/rom2altsound",
    "~/Library/Caches/rom2altsound",
  ]
end
