{
  description = "Nvim";

  inputs = {
    ck3d-configs.url = "github:ck3d/ck3d-nvim-configs";
  };

  outputs = { self, ck3d-configs }:
    let
      inherit (ck3d-configs.inputs) nixpkgs nix2nvimrc;
      inherit (nixpkgs) lib;
      inherit (ck3d-configs.lib lib) readDirNix;

      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
      nix2nvimrcConfigs = {
        inherit (ck3d-configs.nix2nvimrcConfigs)
          bufferline
          cmp# overwrite
          Comment
          diffview
          gitsigns
          global# overwrite
          ibl
          leader
          leap
          lspconfig# sumneko_lua.config.lua
          lsp_extensions
          lsp-status
          lualine# overwrite
          luapad
          neogit
          neovide
          null-ls
          nvim-surround
          nvim-treesitter# overwrite
          nvim-web-devicons
          osc52
          outline
          plantuml-syntax
          project_nvim
          registers
          scrollbar
          telescope# overwrite
          toggleterm
          treesitter-context
          trouble
          vim-speeddating
          vimtex
          which-key# overwrite
          ;
      };
      nix2nvimrcConfigsOverwrite = readDirNix ./configs;
    in
    {
      inherit nix2nvimrcConfigs;

      packages = forAllSystems
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system}
              // { ck3dNvimPkgs = { inherit (ck3d-configs.packages.${system}) outline-nvim; }; };

            nvims = builtins.mapAttrs
              (name: languages: (lib.evalModules {
                modules =
                  (nix2nvimrc.lib.modules pkgs)
                  ++ (builtins.attrValues ck3d-configs.nix2nvimrcModules)
                  ++ (builtins.attrValues nix2nvimrcConfigs)
                  ++ (builtins.attrValues nix2nvimrcConfigsOverwrite)
                  ++ [{
                    wrapper.name = name;
                    inherit languages;
                  }];
              }).config.wrapper.drv)
              rec {
                nvim-admin = [ "nix" "yaml" "bash" "markdown" "json" "toml" ];
                nvim-dev = nvim-admin ++ [
                  "rust"
                  "javascript"
                  "html"
                  "c"
                  "cpp"
                  "css"
                  "make"
                  "graphql"
                  "python"
                  "scheme"
                  "latex"
                  "devicetree"
                  "go"
                  "dhall"
                  "jq"
                  "vue"
                  "typescript"
                  "xml"
                  "plantuml"
                ];
              };
          in
          nvims // { default = nvims.nvim-admin; });
    };
}
