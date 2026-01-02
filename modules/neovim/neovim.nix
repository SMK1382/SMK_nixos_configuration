{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    config = {
      # ─────────────────────
      # Globals
      # ─────────────────────
      globals = {
        mapleader = " ";
        maplocalleader = ",";
      };

      # ─────────────────────
      # Options
      # ─────────────────────
      options = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smartindent = true;
        wrap = false;
        cursorline = true;
        signcolumn = "yes";
        termguicolors = true;
        scrolloff = 8;
        updatetime = 300;
        clipboard = "unnamedplus";
      };

      # ─────────────────────
      # Colorscheme
      # ─────────────────────
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };

      # ─────────────────────
      # Keymaps
      # ─────────────────────
      keymaps = [
        { key = "<leader>e"; action = ":NvimTreeToggle<CR>"; }
        { key = "<leader>ff"; action = ":Telescope find_files<CR>"; }
        { key = "<leader>fg"; action = ":Telescope live_grep<CR>"; }
        { key = "<leader>fb"; action = ":Telescope buffers<CR>"; }
      ];

      # ─────────────────────
      # Plugins
      # ─────────────────────
      plugins = {
        nvim-tree.enable = true;
        telescope.enable = true;
        lualine.enable = true;
        which-key.enable = true;
        comment.enable = true;
        gitsigns.enable = true;
        nvim-autopairs.enable = true;

        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };

        # ─────────────
        # LSP
        # ─────────────
        lsp = {
          enable = true;
          servers = {
            lua_ls.enable = true;
            pyright.enable = true;
            ts_ls.enable = true;
            clangd.enable = true;
            nil_ls.enable = true;
            bashls.enable = true;
          };
        };

        # ─────────────
        # Autocomplete
        # ─────────────
        cmp = {
          enable = true;
          settings = {
            mapping = {
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping.select_next_item()";
              "<S-Tab>" = "cmp.mapping.select_prev_item()";
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "buffer"; }
              { name = "path"; }
            ];
          };
        };

        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;

        luasnip.enable = true;
        dap.enable = true;
      };

      # ─────────────────────
      # Extra Lua
      # ─────────────────────
      extraConfigLua = ''
        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
        })
      '';
    };
  };
}

