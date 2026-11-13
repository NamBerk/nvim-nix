{ pkgs, nix2nvimrc, ... }:
{
  configs.hodur = {
    plugins = with pkgs; [
      (vimUtils.buildVimPlugin {
        pname = "hodur.nvim";
        version = "2026-07-06";
        src = fetchFromGitHub {
          owner = "vodchella";
          repo = "hodur.nvim";
          rev = "main";
          sha256 = "sha256-XTcTsqwiO9no0xsDOSOYqlX24cZZNOiAAgv2MR94DbA="; # update on first build hash mismatch
        };
      })
    ];
    setup.args = {
      # Add any custom options here if needed, e.g.:
      # key = "<C-g>";
    };
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [
        "n"
        "gx"
        "<Cmd>lua require('hodur').open()<CR>"
        { desc = "Open file or URL under cursor"; }
      ]
    ];
  };
}
