{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "luk-pio";
    userEmail = "48261254+luk-pio@users.noreply.github.com";

    extraConfig = {
      core = {
        autocrlf = "input";
        pager = "delta";
      };
      init.defaultBranch = "main";
      credential.helper = "cache";
      interactive.diffFilter = "delta --color-only";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };

    aliases = {
      fza = "!git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o git add";
    };

    lfs.enable = true;
  };
}
