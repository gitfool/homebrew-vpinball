cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "12033259061", intel: "12032724560"),
                                      linux: "12033194589"

  version "10.8.1-6275-dc917531f"
  sha256 arm:          "13f53e48447bca61cafe3c8ba439b21930dd2eabd3b914c195f3dd0a49643fcf",
         intel:        "b584b148758ac5777e7d3a0f75de35247544587fcc6ff2decfd2856bee08ca24",
         x86_64_linux: "22f7c135637995c53bdeaf7e61388ffaa06a0cb90bacedf01f823805a9306364"

  on_macos do
    depends_on macos: :sonoma

    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/VPinballX_BGFX.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPinballX_BGFX"
  end

  url "https://api.github.com/repos/vpinball/vpinball/actions/artifacts/#{artifact_id}/zip",
      header: "Authorization: token #{GitHub::API.credentials}"
  name "VPinballX BGFX (nightly)"
  desc "Visual Pinball BGFX (nightly)"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    # Get unfiltered runs; branch/event/status filters intermittently return stale partial results
    url "https://api.github.com/repos/vpinball/vpinball/actions/workflows/vpinball.yml/runs?per_page=10",
        header: ["Authorization: token #{GitHub::API.credentials}", "Accept: application/vnd.github+json"]
    regex(/^VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release\.#{ext}$/)
    strategy :json do |json, regex|
      json["workflow_runs"]
        .select { |run| run["head_branch"] == "master" && run["event"] == "push" && run["conclusion"] == "success" }
        .sort_by { |run| -run["run_number"] }
        .lazy
        .map { |run| GitHub::API.open_rest("#{run["artifacts_url"]}?per_page=100")["artifacts"] }
        .map { |artifacts| artifacts.reject { |artifact| artifact["expired"] } }
        .map { |artifacts| artifacts.filter_map { |artifact| artifact["name"][regex, 1] } }
        .find(&:any?) || []
    end
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
