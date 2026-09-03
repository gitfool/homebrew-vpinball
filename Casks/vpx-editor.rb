cask "vpx-editor" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "zip"

  version "0.8.38-141-a443535"
  sha256 arm:          "ba0e7e7879ed5e810ca3b1c390be08376c86450a47efd2e4f4948a8977cda8a7",
         x86_64_linux: "a754c0af508b3f28d819bcb8ab4bb60575273fc81c7e865d2f5bd092af466a97"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :monterey

    app "VPX Editor.app"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPX Editor.app"]
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
