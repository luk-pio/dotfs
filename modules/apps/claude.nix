{ config, pkgs, ... }:

{
  # Claude Code settings
  home.file.".claude/settings.json".text = builtins.toJSON {
    permissions = {
      ask = [ "Bash(rm:*)" ];
    };
  };

  # Claude Code custom commands
  home.file.".claude/commands/pr.md".source = ../../config/claude/commands/pr.md;
  home.file.".claude/commands/swmp.md".source = ../../config/claude/commands/swmp.md;
}
