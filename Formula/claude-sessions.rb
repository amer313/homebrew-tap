class ClaudeSessions < Formula
  desc "Auto-resume Claude Code sessions after Mac restart"
  homepage "https://github.com/amer313/claude-sessions"
  url "https://github.com/amer313/claude-sessions/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "032c516534d626f6412998813b8f465aa2daf6609952cecacc2595d5ecbcf5e8"
  license "MIT"
  version "0.2.1"

  depends_on :macos

  def install
    bin.install "claude-sessions"
    # Install the menu bar script to libexec; the main script finds it via
    # a download fallback if not alongside, but shipping it makes install
    # offline-capable and avoids a second HTTP round-trip.
    libexec.install "claude-sessions-menubar.py"
    # Place a symlink next to the bin script so `claude-sessions menubar install`
    # finds it via its `$(dirname "$0")` lookup.
    bin.install_symlink libexec/"claude-sessions-menubar.py"
  end

  def caveats
    <<~EOS
      To finish setup, register the LaunchAgents:
        claude-sessions install

      To add the optional menu bar item:
        claude-sessions menubar install

      Uninstall (removes LaunchAgents, preserves data):
        claude-sessions uninstall
    EOS
  end

  test do
    assert_match "claude-sessions", shell_output("#{bin}/claude-sessions 2>&1", 1)
  end
end
