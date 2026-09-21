cask "vpx-editor" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "zip"

  version "0.9.1-146-805e6c6"
  sha256 arm:          "decf950862acdea080da22d341d301caf2ef71749cedcbc98efa026c6ea502f7",
         x86_64_linux: "62e16d050f26a0e88d7d09003f910058d2c2dc6e43aaea1c3b69e5e8e7622b4a"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :monterey

    app "VPX Editor.app"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/VPX Editor.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPX Editor-linux-x64/vpx-editor"
  end

  url "https://github.com/jsm174/vpx-editor/releases/download/v#{version.split("-").first}/vpx-editor-#{os}-#{arch}-#{version}.#{ext}"
  name "VPX Editor"
  desc "Cross-platform Visual Pinball table editor using Electron and vpin"
  homepage "https://github.com/jsm174/vpx-editor"

  livecheck do
    url :url
    regex(/vpx-editor-#{os}-#{arch}-(\d+(?:\.\d+)+-\d+-[0-9a-f]+)\.#{ext}/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        release["assets"]&.filter_map do |asset|
          match = asset["name"]&.match(regex)
          next if match.blank?

          match[1]
        end
      end.flatten.compact.first
    end
  end

  zap trash: [
    "~/.config/VPX Editor",
    "~/Library/Application Support/VPX Editor",
  ]
end
