cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "13047830512", intel: "13047885605"),
                                      linux: "13048650312"

  version "10.8.1-6507-be55c89cd"
  sha256 arm:          "c8b8fd4c531f4dbe4291cdb570efa72dd8d9cd5c7f465bd8e15627d6f24b1219",
         intel:        "eb330aa2867d943332d2bf5fc9b2a885c8e886a21f743c0e2c7064d0105ca9e4",
         x86_64_linux: "f15814a3355dfeed5695204c979305b8e3ae206ea3cdd2eed71ab514feeafe14"

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
