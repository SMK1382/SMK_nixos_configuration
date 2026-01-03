{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    ##################################
    # Globals
    ##################################
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
    };

    ##################################
    # Options
    ##################################
    opts = {
      number = true;
      relativenumber = false;
      cursorline = true;
      cursorcolumn = false;
      numberwidth = 4;
      relativenumber = true;
      cursorline = true;
      cursorcolumn = false;

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;
      autoindent = true;

      wrap = false;
      linebreak = true;
      breakindent = true;

      termguicolors = true;
      scrolloff = 8;
      sidescrolloff = 8;
      pumheight = 15;
      pumblend = 10;
      winblend = 10;

      updatetime = 100;
      timeoutlen = 300;
      ttimeoutlen = 10;

      clipboard = "unnamedplus";
      splitbelow = true;
      splitright = true;

      undofile = true;
      undolevels = 10000;
      undoreload = 10000;

      ignorecase = true;
      smartcase = true;
      infercase = true;

      inccommand = "split";
      conceallevel = 2;
      concealcursor = "nvic";

      list = true;
      listchars = "tab:▸ ,trail:·,nbsp:␣,extends:»,precedes:«";
      fillchars = "fold: ,vert:▏";

      foldenable = true;
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
      foldlevelstart = 99;

      signcolumn = "yes:1";
      cmdheight = 1;
      showmode = false;
      laststatus = 3;

      mouse = "a";
      mousemodel = "popup";
      guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";

      completeopt = "menuone,noselect,noinsert";
      shortmess = "filnxtToOFWIcC";

      swapfile = false;
      backup = false;
      writebackup = false;

      spell = false;
      spelllang = "en_us";

      virtualedit = "block";
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";
    };

    ##################################
    # Autocommands
    ##################################
    extraConfigLua = ''
        -- Autocommands
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd

        -- Highlight yank
        autocmd('TextYankPost', {
          group = augroup('highlight_yank', {}),
          pattern = '*',
          callback = function()
            vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
          end,
        })

        -- Auto resize splits
        autocmd('VimResized', {
          group = augroup('resize_splits', {}),
          pattern = '*',
          command = 'wincmd =',
        })

        -- Return to last position
        autocmd('BufReadPost', {
          group = augroup('last_position', {}),
          pattern = '*',
          callback = function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end,
        })

        -- Filetype specific
        autocmd('FileType', {
          group = augroup('filetype_settings', {}),
          pattern = { 'markdown', 'text' },
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
          end,
        })

        autocmd('FileType', {
          group = augroup('spell_settings', {}),
          pattern = { 'gitcommit', 'markdown' },
          callback = function()
            vim.opt_local.spell = true
          end,
        })

        autocmd('FileType', {
          group = augroup('help_settings', {}),
          pattern = 'help',
          command = 'wincmd L',
        })

        -- Auto close NvimTree
        autocmd('BufEnter', {
          group = augroup('nvimtree_autoclose', {}),
          callback = function()
            if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
              vim.cmd('quit')
            end
          end,
        })

        -- Diagnostic configuration
        vim.diagnostic.config({
          virtual_text = {
            prefix = '●',
            spacing = 4,
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })

        -- Custom signs for diagnostics
        local signs = { Error = "", Warn = "", Hint = "", Info = "" }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Better completion experience
        vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }

        -- Improved search
        vim.opt.hlsearch = true
        vim.opt.incsearch = true

        -- Persistent undo
        vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

        -- Better diff
        vim.opt.diffopt:append('linematch:60')

        -- Session management
        vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

        vim.diagnostic.config({
        virtual_text = {
        prefix = "●",
        spacing = 4
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded"
      }
       })
    '';

    ##################################
    # Colorscheme
    ##################################
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      transparentBackground = false;
      termColors = true;
      dimInactive = {
        enabled = true;
        shade = "dark";
        percentage = 0.25;
      };
      integrations = {
        cmp = true;
        gitsigns = true;
        treesitter = true;
        telescope = {
          enabled = true;
          style = "nvchad";
        };
        nvimtree = {
          enabled = true;
          showRootFolder = true;
          transparentFolder = false;
        };
        which_key = true;
        illuminate = {
          enabled = true;
          lsp = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
        native_lsp = {
          enabled = true;
          underlines = {
            errors = [ "underline" ];
            hints = [ "underline" ];
            warnings = [ "underline" ];
            information = [ "underline" ];
          };
        };
        navic = {
          enabled = true;
          custom_bg = "NONE";
        };
        dap = {
          enabled = true;
          enable_ui = true;
        };
        neotree = true;
        neotest = true;
        noice = true;
        notify = true;
        semantic_tokens = true;
        symbols_outline = true;
        telekasten = true;
        vim_sneak = true;
        window_picker = true;
      };
    };

    ##################################
    # Keymaps
    ##################################
    keymaps = [
      # Leader mappings
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Toggle file explorer";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Save file";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit";
      }
      {
        mode = "n";
        key = "<leader>Q";
        action = "<cmd>q!<CR>";
        options.desc = "Force quit";
      }
      {
        mode = "n";
        key = "<leader>h";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlight";
      }
      {
        mode = "n";
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<CR>";
        options.desc = "Toggle undo tree";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = "<cmd>SessionManager load_session<CR>";
        options.desc = "Load session";
      }

      # Window management
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move to left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move to down window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move to up window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move to right window";
      }
      {
        mode = "n";
        key = "<leader>=";
        action = "<C-w>=";
        options.desc = "Equalize window sizes";
      }
      {
        mode = "n";
        key = "<leader>|";
        action = "<cmd>vsplit<CR>";
        options.desc = "Vertical split";
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<cmd>split<CR>";
        options.desc = "Horizontal split";
      }

      # Buffer management
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>e #<CR>";
        options.desc = "Switch to other buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bd<CR>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>bd!<CR>";
        options.desc = "Force delete buffer";
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }

      # Telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<CR>";
        options.desc = "Keymaps";
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>Telescope oldfiles<CR>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>Telescope diagnostics<CR>";
        options.desc = "Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope resume<CR>";
        options.desc = "Resume last search";
      }
      {
        mode = "n";
        key = "<leader>fz";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.desc = "Fuzzy find in buffer";
      }

      # LSP
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        options.desc = "Go to declaration";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options.desc = "Go to implementation";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover documentation";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
        options.desc = "Signature help";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename symbol";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua vim.lsp.buf.format({ async = true })<CR>";
        options.desc = "Format buffer";
      }
      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options.desc = "Line diagnostics";
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options.desc = "Previous diagnostic";
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options.desc = "Next diagnostic";
      }

      # Diagnostic
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
        options.desc = "Diagnostics to loclist";
      }

      # Git
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options.desc = "Toggle git blame";
      }

      # Terminal
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>ToggleTerm direction=float<CR>";
        options.desc = "Toggle floating terminal";
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<CR>";
        options.desc = "Toggle horizontal terminal";
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical size=80<CR>";
        options.desc = "Toggle vertical terminal";
      }

      # DAP (Debugging)
      {
        mode = "n";
        key = "<leader>db";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        options.desc = "Toggle breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = "<cmd>lua require('dap').continue()<CR>";
        options.desc = "Continue/Start debugging";
      }
      {
        mode = "n";
        key = "<leader>di";
        action = "<cmd>lua require('dap').step_into()<CR>";
        options.desc = "Step into";
      }
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>lua require('dap').step_over()<CR>";
        options.desc = "Step over";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>lua require('dap').repl.open()<CR>";
        options.desc = "Open REPL";
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = "<cmd>lua require('dap').terminate()<CR>";
        options.desc = "Terminate debugging";
      }

      # Utilities
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>ZenMode<CR>";
        options.desc = "Toggle Zen mode";
      }
      {
        mode = "n";
        key = "<leader>tm";
        action = "<cmd>TodoTelescope<CR>";
        options.desc = "Find TODOs";
      }

      # Quickfix list
      {
        mode = "n";
        key = "<C-q>";
        action = "<cmd>copen<CR>";
        options.desc = "Open quickfix list";
      }
      {
        mode = "n";
        key = "]q";
        action = "<cmd>cnext<CR>";
        options.desc = "Next quickfix item";
      }
      {
        mode = "n";
        key = "[q";
        action = "<cmd>cprev<CR>";
        options.desc = "Previous quickfix item";
      }

      # Improved navigation
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options.desc = "Next search result center";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options.desc = "Prev search result center";
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
        options.desc = "Join lines keeping cursor";
      }
      {
        mode = "x";
        key = "<";
        action = "<gv";
        options.desc = "Shift left keep selection";
      }
      {
        mode = "x";
        key = ">";
        action = ">gv";
        options.desc = "Shift right keep selection";
      }
    ];

    ##################################
    # Plugins
    ##################################
    plugins = {
      # UI Enhancements
      lualine = {
        enable = true;
        theme = "catppuccin";
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
            "diagnostics"
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };

      which-key = {
        enable = true;
        registrations = {
          "<leader>b" = "Buffer";
          "<leader>c" = "Code";
          "<leader>d" = "Debug/Document";
          "<leader>f" = "Find";
          "<leader>g" = "Git";
          "<leader>s" = "Session";
          "<leader>t" = "Terminal/Test";
          "<leader>u" = "Undo";
          "<leader>z" = "Zen";
        };
      };

      neotree = {
        enable = true;
        closeIfLastWindow = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        filesystem = {
          filtered_items = {
            visible = true;
            hide_dotfiles = false;
            hide_gitignored = false;
          };
          followCurrentFile = {
            enabled = true;
          };
          useLibuvFileWatcher = true;
        };
        defaultComponentConfigs = {
          indent = {
            withExpander = true;
            expanderCollapsed = "";
            expanderExpanded = "";
          };
        };
      };

      bufferline = {
        enable = true;
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
        ];
        diagnostics = "nvim_lsp";
        alwaysShowBufferline = false;
        showBufferCloseIcons = false;
        showCloseIcon = false;
        separatorStyle = "slant";
      };

      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = [
              "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
              "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            opts = {
              position = "center";
              hl = "Type";
            };
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                type = "button";
                val = "  Find file";
                on_press.__raw = "function() require('telescope.builtin').find_files() end";
                opts = {
                  shortcut = "f";
                  cursor = 5;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Find word";
                on_press.__raw = "function() require('telescope.builtin').live_grep() end";
                opts = {
                  shortcut = "g";
                  cursor = 6;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Recent files";
                on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
                opts = {
                  shortcut = "r";
                  cursor = 7;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Colorscheme";
                on_press.__raw = "function() require('telescope.builtin').colorscheme() end";
                opts = {
                  shortcut = "c";
                  cursor = 8;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Settings";
                on_press.__raw = "function() require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')}) end";
                opts = {
                  shortcut = "s";
                  cursor = 9;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Quit";
                on_press.__raw = "function() vim.cmd('qa') end";
                opts = {
                  shortcut = "q";
                  cursor = 10;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
            ];
            opts.position = "center";
          }
        ];
      };


      wrap = false;
      linebreak = true;
      breakindent = true;

      termguicolors = true;
      scrolloff = 8;
      sidescrolloff = 8;
      pumheight = 15;
      pumblend = 10;
      winblend = 10;

      updatetime = 100;
      timeoutlen = 300;
      ttimeoutlen = 10;

      clipboard = "unnamedplus";
      splitbelow = true;
      splitright = true;

      undofile = true;
      undolevels = 10000;
      undoreload = 10000;

      ignorecase = true;
      smartcase = true;
      infercase = true;

      inccommand = "split";
      conceallevel = 2;
      concealcursor = "nvic";

      list = true;
      listchars = "tab:▸ ,trail:·,nbsp:␣,extends:»,precedes:«";
      fillchars = "fold: ,vert:▏";

      foldenable = true;
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
      foldlevelstart = 99;

      signcolumn = "yes:1";
      cmdheight = 1;
      showmode = false;
      laststatus = 3;

      mouse = "a";
      mousemodel = "popup";
      guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";

      completeopt = "menuone,noselect,noinsert";
      shortmess = "filnxtToOFWIcC";

      swapfile = false;
      backup = false;
      writebackup = false;

      spell = false;
      spelllang = "en_us";

      virtualedit = "block";
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";
    };

    ##################################
    # Autocommands
    ##################################
    extraConfigLua = ''
      -- Autocommands
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd

      -- Highlight yank
      autocmd('TextYankPost', {
        group = augroup('highlight_yank', {}),
        pattern = '*',
        callback = function()
          vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
        end,
      })

      -- Auto resize splits
      autocmd('VimResized', {
        group = augroup('resize_splits', {}),
        pattern = '*',
        command = 'wincmd =',
      })

      -- Return to last position
      autocmd('BufReadPost', {
        group = augroup('last_position', {}),
        pattern = '*',
        callback = function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
      })

      -- Filetype specific
      autocmd('FileType', {
        group = augroup('filetype_settings', {}),
        pattern = { 'markdown', 'text' },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
        end,
      })

      autocmd('FileType', {
        group = augroup('spell_settings', {}),
        pattern = { 'gitcommit', 'markdown' },
        callback = function()
          vim.opt_local.spell = true
        end,
      })

      autocmd('FileType', {
        group = augroup('help_settings', {}),
        pattern = 'help',
        command = 'wincmd L',
      })

      -- Auto close NvimTree
      autocmd('BufEnter', {
        group = augroup('nvimtree_autoclose', {}),
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd('quit')
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Custom signs for diagnostics
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Better completion experience
      vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }

      -- Improved search
      vim.opt.hlsearch = true
      vim.opt.incsearch = true

      -- Persistent undo
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

      -- Better diff
      vim.opt.diffopt:append('linematch:60')

      -- Session management
      vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

      vim.diagnostic.config({
      virtual_text = {
      prefix = "●",
      spacing = 4
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded"
    }
     })
    '';

    ##################################
    # Colorscheme
    ##################################
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      transparentBackground = false;
      termColors = true;
      dimInactive = {
        enabled = true;
        shade = "dark";
        percentage = 0.25;
      };
      integrations = {
        cmp = true;
        gitsigns = true;
        treesitter = true;
        telescope = {
          enabled = true;
          style = "nvchad";
        };
        nvimtree = {
          enabled = true;
          showRootFolder = true;
          transparentFolder = false;
        };
        which_key = true;
        illuminate = {
          enabled = true;
          lsp = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
        native_lsp = {
          enabled = true;
          underlines = {
            errors = [ "underline" ];
            hints = [ "underline" ];
            warnings = [ "underline" ];
            information = [ "underline" ];
          };
        };
        navic = {
          enabled = true;
          custom_bg = "NONE";
        };
        dap = {
          enabled = true;
          enable_ui = true;
        };
        neotree = true;
        neotest = true;
        noice = true;
        notify = true;
        semantic_tokens = true;
        symbols_outline = true;
        telekasten = true;
        vim_sneak = true;
        window_picker = true;
      };
    };

    ##################################
    # Keymaps
    ##################################
    keymaps = [
      # Leader mappings
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options.desc = "Toggle file explorer"; }
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<CR>"; options.desc = "Save file"; }
      { mode = "n"; key = "<leader>q"; action = "<cmd>q<CR>"; options.desc = "Quit"; }
      { mode = "n"; key = "<leader>Q"; action = "<cmd>q!<CR>"; options.desc = "Force quit"; }
      { mode = "n"; key = "<leader>h"; action = "<cmd>nohlsearch<CR>"; options.desc = "Clear search highlight"; }
      { mode = "n"; key = "<leader>u"; action = "<cmd>UndotreeToggle<CR>"; options.desc = "Toggle undo tree"; }
      { mode = "n"; key = "<leader>s"; action = "<cmd>SessionManager load_session<CR>"; options.desc = "Load session"; }

      # Window management
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Move to left window"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Move to down window"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Move to up window"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Move to right window"; }
      { mode = "n"; key = "<leader>="; action = "<C-w>="; options.desc = "Equalize window sizes"; }
      { mode = "n"; key = "<leader>|"; action = "<cmd>vsplit<CR>"; options.desc = "Vertical split"; }
      { mode = "n"; key = "<leader>-"; action = "<cmd>split<CR>"; options.desc = "Horizontal split"; }

      # Buffer management
      { mode = "n"; key = "<leader>bb"; action = "<cmd>e #<CR>"; options.desc = "Switch to other buffer"; }
      { mode = "n"; key = "<leader>bd"; action = "<cmd>bd<CR>"; options.desc = "Delete buffer"; }
      { mode = "n"; key = "<leader>bD"; action = "<cmd>bd!<CR>"; options.desc = "Force delete buffer"; }
      { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<CR>"; options.desc = "Previous buffer"; }
      { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<CR>"; options.desc = "Next buffer"; }

      # Telescope
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Live grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Find buffers"; }
      { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<CR>"; options.desc = "Help tags"; }
      { mode = "n"; key = "<leader>fk"; action = "<cmd>Telescope keymaps<CR>"; options.desc = "Keymaps"; }
      { mode = "n"; key = "<leader>fo"; action = "<cmd>Telescope oldfiles<CR>"; options.desc = "Recent files"; }
      { mode = "n"; key = "<leader>fd"; action = "<cmd>Telescope diagnostics<CR>"; options.desc = "Diagnostics"; }
      { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope resume<CR>"; options.desc = "Resume last search"; }
      { mode = "n"; key = "<leader>fz"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options.desc = "Fuzzy find in buffer"; }

      # LSP
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; options.desc = "Go to definition"; }
      { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<CR>"; options.desc = "Go to declaration"; }
      { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<CR>"; options.desc = "References"; }
      { mode = "n"; key = "gi"; action = "<cmd>lua vim.lsp.buf.implementation()<CR>"; options.desc = "Go to implementation"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options.desc = "Hover documentation"; }
      { mode = "n"; key = "<C-k>"; action = "<cmd>lua vim.lsp.buf.signature_help()<CR>"; options.desc = "Signature help"; }
      { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options.desc = "Rename symbol"; }
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options.desc = "Code action"; }
      { mode = "n"; key = "<leader>cf"; action = "<cmd>lua vim.lsp.buf.format({ async = true })<CR>"; options.desc = "Format buffer"; }
      { mode = "n"; key = "<leader>cd"; action = "<cmd>lua vim.diagnostic.open_float()<CR>"; options.desc = "Line diagnostics"; }
      { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; options.desc = "Previous diagnostic"; }
      { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; options.desc = "Next diagnostic"; }

      # Diagnostic
      { mode = "n"; key = "<leader>dl"; action = "<cmd>lua vim.diagnostic.setloclist()<CR>"; options.desc = "Diagnostics to loclist"; }

      # Git
      { mode = "n"; key = "<leader>gg"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit"; }
      { mode = "n"; key = "<leader>gb"; action = "<cmd>Gitsigns toggle_current_line_blame<CR>"; options.desc = "Toggle git blame"; }

      # Terminal
      { mode = "t"; key = "<Esc>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }
      { mode = "n"; key = "<leader>tt"; action = "<cmd>ToggleTerm direction=float<CR>"; options.desc = "Toggle floating terminal"; }
      { mode = "n"; key = "<leader>th"; action = "<cmd>ToggleTerm direction=horizontal<CR>"; options.desc = "Toggle horizontal terminal"; }
      { mode = "n"; key = "<leader>tv"; action = "<cmd>ToggleTerm direction=vertical size=80<CR>"; options.desc = "Toggle vertical terminal"; }

      # DAP (Debugging)
      { mode = "n"; key = "<leader>db"; action = "<cmd>lua require('dap').toggle_breakpoint()<CR>"; options.desc = "Toggle breakpoint"; }
      { mode = "n"; key = "<leader>dc"; action = "<cmd>lua require('dap').continue()<CR>"; options.desc = "Continue/Start debugging"; }
      { mode = "n"; key = "<leader>di"; action = "<cmd>lua require('dap').step_into()<CR>"; options.desc = "Step into"; }
      { mode = "n"; key = "<leader>do"; action = "<cmd>lua require('dap').step_over()<CR>"; options.desc = "Step over"; }
      { mode = "n"; key = "<leader>dr"; action = "<cmd>lua require('dap').repl.open()<CR>"; options.desc = "Open REPL"; }
      { mode = "n"; key = "<leader>dt"; action = "<cmd>lua require('dap').terminate()<CR>"; options.desc = "Terminate debugging"; }

      # Utilities
      { mode = "n"; key = "<leader>z"; action = "<cmd>ZenMode<CR>"; options.desc = "Toggle Zen mode"; }
      { mode = "n"; key = "<leader>tm"; action = "<cmd>TodoTelescope<CR>"; options.desc = "Find TODOs"; }

      # Quickfix list
      { mode = "n"; key = "<C-q>"; action = "<cmd>copen<CR>"; options.desc = "Open quickfix list"; }
      { mode = "n"; key = "]q"; action = "<cmd>cnext<CR>"; options.desc = "Next quickfix item"; }
      { mode = "n"; key = "[q"; action = "<cmd>cprev<CR>"; options.desc = "Previous quickfix item"; }

      # Improved navigation
      { mode = "n"; key = "n"; action = "nzzzv"; options.desc = "Next search result center"; }
      { mode = "n"; key = "N"; action = "Nzzzv"; options.desc = "Prev search result center"; }
      { mode = "n"; key = "J"; action = "mzJ`z"; options.desc = "Join lines keeping cursor"; }
      { mode = "x"; key = "<"; action = "<gv"; options.desc = "Shift left keep selection"; }
      { mode = "x"; key = ">"; action = ">gv"; options.desc = "Shift right keep selection"; }
    ];

    ##################################
    # Plugins
    ##################################
    plugins = {
      # UI Enhancements
      lualine = {
        enable = true;
        theme = "catppuccin";
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "encoding" "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };

      which-key = {
        enable = true;
        registrations = {
          "<leader>b" = "Buffer";
          "<leader>c" = "Code";
          "<leader>d" = "Debug/Document";
          "<leader>f" = "Find";
          "<leader>g" = "Git";
          "<leader>s" = "Session";
          "<leader>t" = "Terminal/Test";
          "<leader>u" = "Undo";
          "<leader>z" = "Zen";
        };
      };

      neotree = {
        enable = true;
        closeIfLastWindow = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        filesystem = {
          filtered_items = {
            visible = true;
            hide_dotfiles = false;
            hide_gitignored = false;
          };
          followCurrentFile = {
            enabled = true;
          };
          useLibuvFileWatcher = true;
        };
        defaultComponentConfigs = {
          indent = {
            withExpander = true;
            expanderCollapsed = "";
            expanderExpanded = "";
          };
        };
      };

      bufferline = {
        enable = true;
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
        ];
        diagnostics = "nvim_lsp";
        alwaysShowBufferline = false;
        showBufferCloseIcons = false;
        showCloseIcon = false;
        separatorStyle = "slant";
      };

      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = [
              "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
              "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            opts = {
              position = "center";
              hl = "Type";
            };
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                type = "button";
                val = "  Find file";
                on_press.__raw = "function() require('telescope.builtin').find_files() end";
                opts = {
                  shortcut = "f";
                  cursor = 5;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Find word";
                on_press.__raw = "function() require('telescope.builtin').live_grep() end";
                opts = {
                  shortcut = "g";
                  cursor = 6;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Recent files";
                on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
                opts = {
                  shortcut = "r";
                  cursor = 7;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Colorscheme";
                on_press.__raw = "function() require('telescope.builtin').colorscheme() end";
                opts = {
                  shortcut = "c";
                  cursor = 8;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Settings";
                on_press.__raw = "function() require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')}) end";
                opts = {
                  shortcut = "s";
                  cursor = 9;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
              {
                type = "button";
                val = "  Quit";
                on_press.__raw = "function() vim.cmd('qa') end";
                opts = {
                  shortcut = "q";
                  cursor = 10;
                  width = 40;
                  align_shortcut = "right";
                  hl = "Keyword";
                  hl_shortcut = "String";
                };
              }
            ];
            opts.position = "center";
          }
        ];
      };

      # Editor Enhancements
      comment.enable = true;

      nvim-autopairs = {
        enable = true;
        checkTs = true;
        tsConfig = {
          lua = [
            "string"
            "source"
          ];
          javascript = [
            "string"
            "template_string"
          ];
          lua = [ "string" "source" ];
          javascript = [ "string" "template_string" ];
        };
      };

      gitsigns = {
        enable = true;
        signs = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "┆";
          };
          add = { text = "│"; };
          change = { text = "│"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; };
          untracked = { text = "┆"; };
        };
        currentLineBlame = true;
        currentLineBlameOpts = {
          virtText = true;
          virtTextPos = "eol";
          delay = 100;
          ignoreWhitespace = false;
        };
      };

      illuminate = {
        enable = true;
        delay = 200;
        largeFileCutoff = 2000;
        largeFileOverrides = {
          providers = [ "lsp" ];
        };
      };

      indent-blankline = {
        enable = true;
        showCurrentContext = true;
        showCurrentContextStart = true;
        useTreesitter = true;
        char = "▏";
        contextChar = "▏";
        showEndOfLine = true;
      };

      # Telescope
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          undo.enable = true;
          file-browser.enable = true;
        };
        defaults = {
          layout_strategy = "horizontal";
          layout_config = {
            width = 0.95;
            height = 0.85;
            preview_cutoff = 120;
            prompt_position = "top";
          };
          sorting_strategy = "ascending";
          prompt_prefix = "   ";
          selection_caret = "  ";
          entry_prefix = "  ";
          initial_mode = "insert";
          selection_strategy = "reset";
          scroll_strategy = "cycle";
          colorDevicons = true;
          set_env = {
            COLORTERM = "truecolor";
          };
          mappings = {
            i = {
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
              "<C-n>" = "cycle_history_next";
              "<C-p>" = "cycle_history_prev";
              "<C-c>" = "close";
            };
            n = {
              "j" = "move_selection_next";
              "k" = "move_selection_previous";
              "q" = "close";
            };
          };
        };
      };

      # Treesitter
      treesitter = {
        enable = true;
        nixGrammars = true;
        ensureInstalled = [
          "bash"
          "c"
          "cpp"
          "css"
          "dockerfile"
          "fish"
          "gitignore"
          "go"
          "html"
          "javascript"
          "json"
          "jsonc"
          "lua"
          "make"
          "markdown"
          "markdown_inline"
          "nix"
          "python"
          "regex"
          "rust"
          "sql"
          "toml"
          "tsx"
          "typescript"
          "vim"
          "vimdoc"
          "yaml"
        ];
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "gnn";
            nodeIncremental = "grn";
            scopeIncremental = "grc";
            nodeDecremental = "grm";
          };
        };
        indent.enable = true;
        folding.enable = true;
        nvimTreesitterContext.enable = true;
        playground.enable = true;
        query.enable = true;
        autotag.enable = true;
        textobjects = {
          enable = true;
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
            };
          };
          move = {
            enable = true;
            setJumps = true;
            gotoNextStart = {
              "]m" = "@function.outer";
              "]]" = "@class.outer";
            };
            gotoNextEnd = {
              "]M" = "@function.outer";
              "][" = "@class.outer";
            };
            gotoPreviousStart = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
            gotoPreviousEnd = {
              "[M" = "@function.outer";
              "[]" = "@class.outer";
            };
          };
        };
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          lua-ls = {
            enable = true;
            settings = {
              stiffness = 2;
              trailing_stiffness = 0.3;
              distance_stop_animating = 0.5;
              hide_target_hack = true;
              Lua = {
                runtime = {
                  version = "LuaJIT";
                };
                diagnostics = {
                  globals = [ "vim" ];
                };
                workspace = {
                  checkThirdParty = false;
                };
                telemetry = {
                  enable = false;
                };
              };
            };
          };
          pyright.enable = true;
          tsserver.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
        keymaps = {
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>cd" = "open_float";
            "<leader>cl" = "setloclist";
          };
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gr = "references";
            gi = "implementation";
            K = "hover";
            "<C-k>" = "signature_help";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>cf" = "format";
          };
        };
      };

      lsp-format.enable = true;
      lsp-lens.enable = true;
      lsp-inlayhints.enable = true;

      # Autocomplete (CMP)
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };
          formatting.fields = [
            "kind"
            "abbr"
            "menu"
          ];
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lua.enable = true;

      luasnip = {
        enable = true;
        fromVscode = [ { } ];
        fromLua = [ { } ];
      };

      lspkind = {
        enable = true;
        mode = "symbol_text";
        preset = "codicons";
        symbolMap = {
          Text = "󰉿";
          Method = "󰆧";
          Function = "󰊕";
          Constructor = "";
          Field = "󰜢";
          Variable = "󰀫";
          Class = "󰠱";
          Interface = "";
          Module = "";
          Property = "󰜢";
          Unit = "󰑭";
          Value = "󰎠";
          Enum = "";
          Keyword = "󰌋";
          Snippet = "";
          Color = "󰏘";
          File = "󰈙";
          Reference = "󰈇";
          Folder = "󰉋";
          EnumMember = "";
          Constant = "󰏿";
          Struct = "󰙅";
          Event = "";
          Operator = "󰆕";
          TypeParameter = "";
        };
      };

      # Formatter / Linter
      conform-nvim = {
        enable = true;
        formatOnSave = {
          timeoutMs = 500;
          lspFallback = true;
        };
        formattersByFt = {
          lua = [ "stylua" ];
          nix = [ "nixpkgs-fmt" ];
          python = [
            "isort"
            "black"
          ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
          markdown = [ "prettier" ];
          html = [ "prettier" ];
          css = [ "prettier" ];
          scss = [ "prettier" ];
          rust = [ "rustfmt" ];
          go = [ "gofmt" ];
          sh = [ "shfmt" ];
        };
        formatters = {
          shfmt = {
            prepend_args = [
              "-i"
              "2"
            ];
          };
        };
      };

      # Debug
      dap = {
        enable = true;
        extensions = {
          dap-ui.enable = true;
          dap-virtual-text.enable = true;
        };
      };

      # Extra utilities
      toggleterm = {
        enable = true;
        direction = "float";
        floatOpts = {
          border = "curved";
          winblend = 3;
        };
        persistMode = false;
        autoScroll = true;
      };

      zen-mode.enable = true;
      todo-comments.enable = true;
      session-manager.enable = true;
      undotree.enable = true;
      lazygit.enable = true;
      vim-fugitive.enable = true;
      vim-sleuth.enable = true;
      marks.enable = true;
      surround.enable = true;
      hop.enable = true;
    };

    plugins.cursors = {
      enable = true;
      defaultCursors = {
        normal = {
          shape = "block";
          blink = true;
          blinkSpeed = 500; # سرعت چشمک زدن (میلی‌ثانیه)
          trail = {
            enable = true;
            length = 5; # طول دنباله
            fade = true; # محو شدن
          };
        };
        insert = {
          shape = "vertical";
          blink = true;
          blinkSpeed = 500;
          trail = {
            enable = true;
            length = 3;
            fade = true;
          };
        };
        visual = {
          shape = "block";
          blink = true;
          blinkSpeed = 300;
          trail = {
            enable = true;
            length = 10;
            fade = false;
          };
        };
      };
    };
  };
  enable = true;
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT";
      };
      diagnostics = {
        globals = [ "vim" ];
      };
      workspace = {
        checkThirdParty = false;
      };
      telemetry = {
        enable = false;
      };
    };
  };
};
          pyright.enable = true;
          tsserver.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
        keymaps = {
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>cd" = "open_float";
            "<leader>cl" = "setloclist";
          };
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gr = "references";
            gi = "implementation";
            K = "hover";
            "<C-k>" = "signature_help";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>cf" = "format";
          };
        };
      };

      lsp-format.enable = true;
      lsp-lens.enable = true;
      lsp-inlayhints.enable = true;

      # Autocomplete (CMP)
      cmp = {
  enable = true;
  settings = {
    snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    window = {
      completion.border = "rounded";
      documentation.border = "rounded";
    };
    formatting.fields = [ "kind" "abbr" "menu" ];
    mapping = {
      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-e>" = "cmp.mapping.abort()";
      "<CR>" = "cmp.mapping.confirm({ select = true })";
    };
    sources = [
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "buffer"; }
      { name = "path"; }
    ];
  };
};
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lua.enable = true;

      luasnip = {
        enable = true;
        fromVscode = [ {} ];
        fromLua = [ {} ];
      };

      lspkind = {
        enable = true;
        mode = "symbol_text";
        preset = "codicons";
        symbolMap = {
          Text = "󰉿";
          Method = "󰆧";
          Function = "󰊕";
          Constructor = "";
          Field = "󰜢";
          Variable = "󰀫";
          Class = "󰠱";
          Interface = "";
          Module = "";
          Property = "󰜢";
          Unit = "󰑭";
          Value = "󰎠";
          Enum = "";
          Keyword = "󰌋";
          Snippet = "";
          Color = "󰏘";
          File = "󰈙";
          Reference = "󰈇";
          Folder = "󰉋";
          EnumMember = "";
          Constant = "󰏿";
          Struct = "󰙅";
          Event = "";
          Operator = "󰆕";
          TypeParameter = "";
        };
      };

      # Formatter / Linter
      conform-nvim = {
        enable = true;
        formatOnSave = {
          timeoutMs = 500;
          lspFallback = true;
        };
        formattersByFt = {
          lua = [ "stylua" ];
          nix = [ "nixpkgs-fmt" ];
          python = [ "isort" "black" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
          markdown = [ "prettier" ];
          html = [ "prettier" ];
          css = [ "prettier" ];
          scss = [ "prettier" ];
          rust = [ "rustfmt" ];
          go = [ "gofmt" ];
          sh = [ "shfmt" ];
        };
        formatters = {
          shfmt = {
            prepend_args = [ "-i" "2" ];
          };
        };
      };

      # Debug
      dap = {
        enable = true;
        extensions = {
          dap-ui.enable = true;
          dap-virtual-text.enable = true;
        };
      };

      # Extra utilities
      toggleterm = {
        enable = true;
        direction = "float";
        floatOpts = {
          border = "curved";
          winblend = 3;
        };
        persistMode = false;
        autoScroll = true;
      };

      zen-mode.enable = true;
      todo-comments.enable = true;
      session-manager.enable = true;
      undotree.enable = true;
      lazygit.enable = true;
      vim-fugitive.enable = true;
      vim-sleuth.enable = true;
      marks.enable = true;
      surround.enable = true;
      hop.enable = true;
    };

  };
}
