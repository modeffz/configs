------------------------------
-- BASIC SETTINGS
------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.smartindent = true
--vim.opt.breakindent = true
------------------------------
-- INSTALL LAZY.NVIM
------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------------
-- PLUGINS
------------------------------
require("lazy").setup({
    -- NOTIFY
     {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = function()
      require("live-server").setup({
        port = 5500,
        browser_command = "firefox", -- или "firefox", "chrome", "brave", ...
        quiet = false,
      })
    end,
    },
    { "rcarriga/nvim-notify" },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                char = "▏",
            },
        },
        config = function(_, opts)
            require("ibl").setup(opts)
        end,
    },
    {
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup({
                auto_cmd = true,
                filetype_exclude = {
                    "netrw",
                    "tutor",
                    "dashboard",
                }
            })
        end,
    },
    -- MENU
    {

        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
        require("dashboard").setup({
            theme = "hyper",
                config = {
                    header = {
                        "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
                        "████╗  ██║██║   ██║██║████╗ ████║",
                        "██╔██╗ ██║██║   ██║██║██╔████╔██║",
                        "██║╚██╗██║██║   ██║██║██║╚██╔╝██║",
                        "██║ ╚████║╚██████╔╝██║██║ ╚═╝ ██║",
                        "╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝     ╚═╝",
                    },
                shortcut = {
                    { desc = "Find File", group = "Label", action = "Telescope find_files", key = "f" },
                    { desc = "Open Tree", group = "Label", action = "NvimTreeToggle", key = "t" },
                    { desc = "Quit",      group = "Error", action = "qa",               key = "q" },
                },
                footer = { "By modeffz ❤️" }
                }
        })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },


    -- UI / THEMES
    { "folke/tokyonight.nvim" },
    { "nvim-lualine/lualine.nvim" },

    -- FILE TREE (VS CODE SIDE BAR)
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- FILE LINE 
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
            options = {
                mode = "buffers",
                diagnostics = "nvim_lsp",
                separator_style = "slant",
            }
            })

    -- горячие клавиши
            vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
            vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
        end,
    },

    -- FUZZY SEARCH LIKE CTRL+P
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    -----------------------------
    -- LSP SYSTEM
    -----------------------------
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -----------------------------
    -- COMPLETION
    -----------------------------
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp" },

    -----------------------------
    -- SNIPPETS
    -----------------------------
    { "L3MON4D3/LuaSnip" },
    { 
        'vyfor/cord.nvim',
        build = ':Cord update',
    },
})

------------------------------
-- COLORS
------------------------------
vim.cmd("colorscheme tokyonight")

------------------------------
-- LUALINE
------------------------------
require("lualine").setup()

------------------------------
-- FILE TREE
------------------------------
require("nvim-tree").setup()
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

------------------------------
-- TELESCOPE
------------------------------
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", telescope.find_files)
vim.keymap.set("n", "<leader>fg>", telescope.live_grep)

------------------------------
-- MASON + LSP CONFIG
------------------------------
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    -- your languages
    "clangd",             -- C/C++
    "pyright",            -- Python
    "ts_ls",              -- TypeScript/JavaScript (typescript-language-server)
    "rust_analyzer",      -- Rust
    "bashls",             -- Bash
    "jsonls",             -- JSON
    "yamlls",             -- YAML
    "cssls",              -- CSS
    "html",               -- HTML
    "lua_ls",             -- Lua (for Neovim config)
  }
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  --"clangd",
  "pyright",
  "ts_ls",
  "rust_analyzer",
  "bashls",
  "jsonls",
  "yamlls",
  "cssls",
  "html",
  "lua_ls",
  "gopls",
  "golangci-lint-langserver",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end

------------------------------
-- CMP AUTOCOMPLETE
------------------------------
local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- подтверждение

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },
})
vim.notify = require("notify")


vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:find("require%(\'lspconfig\'%)") then
    return
  end
  return require("notify")(msg, level, opts)
end
