-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require "custom.refactor_function_cpp"
-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
-- White Space
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- testing ESC to fj

vim.api.nvim_set_keymap('i', 'jf', '<ESC>', { noremap = true, silent = true })

-- navigate up/down physical lines on wrap
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Up>', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Down>', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Up>', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<s-Down>', 'gjzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<s-Up>', 'gkzz', { noremap = true, silent = true })

-- Control Left or Right for move Cursor to start or end of Line
vim.api.nvim_set_keymap('n', '<c-Left>', '^^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<c-Left>', '^^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-Right>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<c-Right>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '^^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-h>', '^^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '$', { noremap = true, silent = true })

-- double "," adds semikolon at end of line
vim.api.nvim_set_keymap('n', ',,', '$a;<Esc>', { noremap = true, silent = true })
-- [[ Basic Keymaps ]]

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', 'gb', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>g', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', 'gq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Normal mode mappings
-- vim.keymap.set('n', '<C-a>', 'ggvG', { desc = ’select all' })
vim.keymap.set('n', '<C-a>', 'ggvG', { desc = 'select all' })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'previous buffer' })
vim.keymap.set('n', '<C-n>', '<cmd> Telescope <CR>', { desc = 'Telescope' })
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle <CR>', { desc = 'File Browser' })
vim.keymap.set('n', '<leader>c', ':bd<CR>')
vim.keymap.set('n', '<leader>qn', ':qa!<cr>')
vim.keymap.set('n', '<leader>h', ':ClangdSwitchSourceHeader<cr>', { desc = 'switch header source' })
vim.keymap.set('n', '<leader>rf', ":lua require('custom.refactor_function_cpp').moveFunctionToCpp()<CR>", { desc = 'Refactoring' })
vim.keymap.set('n', 'gn', function()
  vim.diagnostic.goto_next { border = 'rounded' }
end, { desc = 'LSP Next Issue' })
vim.keymap.set('n', 'rn', function()
  vim.lsp.buf.rename()
end, { desc = 'rename symbol' })

-- toggle Terminal split
local split_type = 'horizontal'


vim.keymap.set('n', '<leader>t', function()
  local terminal_tag = "my_unique_terminal"
  local terminal_buf = nil

  -- Check all buffers to see if our specific terminal buffer exists
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf_id].buftype == 'terminal' and vim.api.nvim_buf_get_var(buf_id, "terminal_tag") == terminal_tag then
      terminal_buf = buf_id
      -- Check if the terminal buffer is currently displayed in any window
      for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win_id) == buf_id then
          -- If terminal is visible, hide the window
          vim.api.nvim_win_hide(win_id)
          return -- Stop execution after hiding the terminal
        end
      end
      break
    end
  end

  -- Decide based on terminal buffer presence
  if terminal_buf then
    if split_type == 'horizontal' then
      vim.cmd('split')
      vim.cmd('wincmd J')
      vim.cmd('resize 10')
    else
      vim.cmd('vsplit')
      vim.cmd('wincmd L')
      vim.cmd('vertical resize 30')
    end
    vim.api.nvim_set_current_buf(terminal_buf)
    vim.cmd('startinsert')
  else
    -- Create a new terminal if none was found
    if split_type == 'horizontal' then
      vim.cmd('split')
      vim.cmd('wincmd J')
      vim.cmd('resize 10')
    else
      vim.cmd('vsplit')
      vim.cmd('wincmd L')
      vim.cmd('vertical resize 30')
    end
    vim.cmd('terminal')
    -- Assign a unique tag to the new terminal buffer
    vim.api.nvim_buf_set_var(0, "terminal_tag", terminal_tag)
    vim.cmd('startinsert')
  end
end, {desc = 'Toggle terminal split'})

vim.keymap.set('t', '<leader>t', function()
  vim.cmd('hide')
end, {desc = 'Hide terminal'})
-- Visual mode mappings
vim.keymap.set('v', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, desc = 'Move up' })
vim.keymap.set('v', '<S-Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, desc = 'Move up' })
vim.keymap.set('v', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, desc = 'Move down' })
vim.keymap.set('v', '<S-Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, desc = 'Move down' })
vim.keymap.set('x', '<', "v:count || mode(1)[0:1] == 'no' ? '<gv' : '<gv'", { expr = true, silent = true, noremap = true, desc = 'Indent left and reselect' })
vim.keymap.set('x', '>', "v:count || mode(1)[0:1] == 'no' ? '>gv' : '>gv'", { expr = true, silent = true, noremap = true, desc = 'Indent right and reselect' })

-- Insert mode mappings
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'escape insert mode', nowait = true })

-- Additional command mode shortcut
vim.keymap.set('n', ';', ':', { desc = 'CMD enter command mode' })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
local lastline = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
  "BufReadPost",
  {callback =
    function()
      local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
      if {row, col} ~= {0, 0} then
        vim.api.nvim_win_set_cursor(0, {row, 0})
      end
    end,
    group = lastline
  }
)
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Use `opts = {}` to force a plugin to be loaded.

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
 -- Fugitive Plugin
  {
    'tpope/vim-fugitive',
    config = function()
      -- Beispiel: Keymap für :Gdiffsplit hinzufügen
      vim.keymap.set('n', '<leader>gs', ':Gdiffsplit<CR>', { desc = '' })
    end,
  },
 -- DiffView Plugin
  {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('diffview').setup {
        enhanced_diff_hl = true, -- Aktiviert erweitertes Highlighting
      }

      -- Keymaps für DiffView
      vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>', { desc = '[D]iffview [O]pen' })
      vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = '[D]iffview [C]lose' })
      vim.keymap.set('n', '<leader>dh', ':DiffviewFileHistory<CR>', { desc = '[D]iffview [H]istory' })
    end,
  },

  {-- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          file_ignore_patterns = { "node_modules" },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
            i = { ["<C-x>"] = require('telescope.actions').delete_buffer,},
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })

      vim.keymap.set('n', '<leader>fj', function()
        require('telescope.builtin').jumplist({ initial_mode = 'normal' })
      end, { desc = '[F]ind [J]umplist' })

      vim.keymap.set('n', '<leader>fo', function()
        require('telescope.builtin').oldfiles({ initial_mode = 'normal' })
      end, { desc = '[F]ind Recent Files ("." for repeat)' })

      vim.keymap.set('n', '<leader><leader>', function()
        require('telescope.builtin').buffers({ initial_mode = 'normal' })
      end, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>t', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
-- LSP Configuration & Plugins (Simplified Version)
{
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    -- Setup neodev BEFORE lspconfig
    require('neodev').setup()
    
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Setup Mason
    require('mason').setup()

    -- Manual LSP server setup
    -- lua_ls
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            -- wie gehabt; lädt dein Runtime als Bibliothek
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- clangd
    vim.lsp.config('clangd', {
      capabilities = capabilities,
      cmd = { "clangd", "--header-insertion=never" },
      -- optional: weitere clangd-Flags hier ergänzen
    })

    -- rust_analyzer
    vim.lsp.config('rust_analyzer', {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    })
    -- Setup mason-tool-installer for automatic tool installation
    require('mason-tool-installer').setup {
      ensure_installed = {
        'lua-language-server',
        'clangd',
        'rust-analyzer',
        'stylua',
      }
    }
  end,
},
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {

          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),


        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    'catppuccin/nvim',
  },
  {
    'folke/tokyonight.nvim',
  },
  {
    'cocopon/iceberg.vim',
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    'EdenEast/nightfox.nvim',
  },
  {
    'marko-cerovac/material.nvim',
  },
  {
    'xStormyy/bearded-theme.nvim',
  },
  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'kanagawa-wave'
      -- vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('nvim-tree').setup {
        git = {
          enable = true,
        },

        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
            },
          },
        },

        actions = {
          open_file = {
            quit_on_open = true,
            resize_window = true,
          },
        },
      }
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
    -- Konfiguriere Lazy-Loading Trigger
    keys = { "<leader>e" }
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'onedark',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch'},
          lualine_c = {'filename'},
          lualine_x = {'diagnostics','encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'cpp','cmake','html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
}, {
    defaults = {
    pin = true,
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
