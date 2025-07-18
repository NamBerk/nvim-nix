{
  description = "Nvim";

  inputs = {
    ck3d-configs.url = "github:ck3d/ck3d-nvim-configs";
  };

  outputs =
    { self, ck3d-configs }:
    let
      inherit (ck3d-configs.inputs) nixpkgs nix2nvimrc;
      inherit (nixpkgs) lib;
      inherit (ck3d-configs.lib lib) readDirNix;

      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
      nix2nvimrcConfigs = {
        inherit (ck3d-configs.nix2nvimrcConfigs)
          bufferline
          cmp # overwrite
          Comment
          diffview
          gitsigns
          ibl
          leader
          leap
          lspconfig # sumneko_lua.config.lua
          lsp_extensions
          lsp-status
          lualine # overwrite
          luapad
          neogit
          neovide
          null-ls
          nvim-surround
          nvim-treesitter # overwrite
          nvim-web-devicons
          osc52
          outline
          plantuml-syntax
          project_nvim
          registers
          telescope # overwrite
          toggleterm
          treesitter-context
          trouble
          vim-speeddating
          vimtex
          which-key # overwrite
          ;
      };
      nix2nvimrcConfigsOverwrite = readDirNix ./configs;
    in
    {
      inherit nix2nvimrcConfigs;

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system} // {
            ck3dNvimPkgs = {
              inherit (ck3d-configs.packages.${system}) outline-nvim nvim-tsserver-vue-env cmp-yank;
            };
          };

          grouped-languages = rec {
            nvim-min = [ ];
            nvim-admin = [
              "nix"
              "yaml"
              "bash"
              "markdown"
              "json"
              "toml"
            ];
            nvim-web = nvim-admin ++ [
              "javascript"
              "html"
              "vue"
              "typescript"
              "css"
            ];
            nvim-author = nvim-admin ++ [
              "latex"
              "typst"
              "plantuml"
            ];
            nvim-dev = lib.unique (
              nvim-admin
              ++ nvim-web
              ++ nvim-author
              ++ [
                "rust"
                "c"
                "cpp"
                "make"
                "graphql"
                "python"
                "scheme"
                "devicetree"
                "go"
                "jq"
                "xml"
              ]
            );
          };

          nvims = builtins.listToAttrs (
            builtins.concatMap (
              group:
              let
                evaluation = lib.evalModules {
                  modules =
                    (nix2nvimrc.lib.modules pkgs)
                    ++ (builtins.attrValues ck3d-configs.nix2nvimrcModules)
                    ++ (builtins.attrValues nix2nvimrcConfigs)
                    ++ (builtins.attrValues nix2nvimrcConfigsOverwrite)
                    ++ [
                      {
                        wrapper.name = group;
                        languages = grouped-languages.${group};
                      }
                    ];
                };
              in
              builtins.concatMap
                (
                  drv:
                  lib.optional (drv.meta ? platforms && builtins.elem system drv.meta.platforms) {
                    name = drv.pname;
                    value = drv;
                  }
                )
                [
                  evaluation.config.wrapper.drv
                  evaluation.config.bubblewrap.drv
                ]
            ) (builtins.attrNames grouped-languages)
          );
        in
        nvims // { default = nvims.nvim-admin; }
      );

      checks = forAllSystems (
        system:
        let
          packages = self.packages.${system};
        in
        packages
        // (builtins.foldl' (
          acc: package:
          acc
          // (lib.mapAttrs' (test: value: {
            name = package + "-test-" + test;
            inherit value;
          }) (packages.${package}.tests or { }))
        ) { } (builtins.attrNames packages))
      );
    };
}
