local function zigzag_badges()
  local badges = {
    {
      indent = 2,
      lines = {
        "┌────────── · ──────────┐",
        "│   D E D I C A T E    │",
        "└────────── · ──────────┘",
      },
    },
    {
      indent = 18,
      lines = {
        "┌────────── · ──────────┐",
        "│       W O R K         │",
        "└────────── · ──────────┘",
      },
    },
    {
      indent = 8,
      lines = {
        "┌────────── · ──────────┐",
        "│      F O C U S        │",
        "└────────── · ──────────┘",
      },
    },
  }

  local lines = {}

  for _, badge in ipairs(badges) do
    local indent = string.rep(" ", badge.indent)

    for _, line in ipairs(badge.lines) do
      table.insert(lines, indent .. line)
    end

    table.insert(lines, "")
  end

  return table.concat(lines, "\n")
end

return {
  "snacks.nvim",
  opts = function(_, opts)
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}

    opts.dashboard.preset.header = zigzag_badges()

    return opts
  end,
}
