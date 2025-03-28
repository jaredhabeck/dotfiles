return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      php = { "./vendor/bin/pint" },
      javascript = { "eslint_d", stop_after_first = true },
      typescript = { "eslint_d", stop_after_first = true },
      typescriptreact = { "eslint_d", stop_after_first = true },
      python = { "ruff_fix", "ruff_format" },
      json = { "prettier" },
      lua = { "stylua" }
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      -- lsp_format = "fallback",
    },
  },
}
