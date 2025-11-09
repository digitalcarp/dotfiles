-- The following is a modified version of ellisonleao/gruvbox.nvim.



-- MIT License
--
-- Copyright (c) 2021 NpX
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.



---@class Gruvbox
---@field config GruvboxConfig
---@field palette GruvboxPalette
local Gruvbox = {}

---@alias Contrast "hard" | "soft" | ""

---@class ItalicConfig
---@field strings boolean
---@field comments boolean
---@field operators boolean
---@field folds boolean
---@field emphasis boolean

---@class HighlightDefinition
---@field fg string?
---@field bg string?
---@field sp string?
---@field blend integer?
---@field bold boolean?
---@field standout boolean?
---@field underline boolean?
---@field undercurl boolean?
---@field underdouble boolean?
---@field underdotted boolean?
---@field strikethrough boolean?
---@field italic boolean?
---@field reverse boolean?
---@field nocombine boolean?

---@class GruvboxConfig
---@field bold boolean?
---@field contrast Contrast?
---@field dim_inactive boolean?
---@field inverse boolean?
---@field invert_selection boolean?
---@field invert_signs boolean?
---@field invert_tabline boolean?
---@field italic ItalicConfig?
---@field overrides table<string, HighlightDefinition>?
---@field palette_overrides table<string, string>?
---@field strikethrough boolean?
---@field terminal_colors boolean?
---@field transparent_mode boolean?
---@field undercurl boolean?
---@field underline boolean?
local default_config = {
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true,
  contrast = "",
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
}

Gruvbox.config = vim.deepcopy(default_config)

---@class GruvboxPalette
Gruvbox.palette = {
  dark0_hard = "#1d2021",
  dark0 = "#282828",
  dark0_soft = "#32302f",
  dark1 = "#3c3836",
  dark2 = "#504945",
  dark3 = "#665c54",
  dark4 = "#7c6f64",
  light0_hard = "#f9f5d7",
  light0 = "#fbf1c7",
  light0_soft = "#f2e5bc",
  light1 = "#ebdbb2",
  light2 = "#d5c4a1",
  light3 = "#bdae93",
  light4 = "#a89984",
  bright_red = "#fb4934",
  bright_green = "#b8bb26",
  bright_yellow = "#fabd2f",
  bright_blue = "#83a598",
  bright_purple = "#d3869b",
  bright_aqua = "#8ec07c",
  bright_orange = "#fe8019",
  neutral_red = "#cc241d",
  neutral_green = "#98971a",
  neutral_yellow = "#d79921",
  neutral_blue = "#458588",
  neutral_purple = "#b16286",
  neutral_aqua = "#689d6a",
  neutral_orange = "#d65d0e",
  faded_red = "#9d0006",
  faded_green = "#79740e",
  faded_yellow = "#b57614",
  faded_blue = "#076678",
  faded_purple = "#8f3f71",
  faded_aqua = "#427b58",
  faded_orange = "#af3a03",
  dark_red_hard = "#792329",
  dark_red = "#722529",
  dark_red_soft = "#7b2c2f",
  light_red_hard = "#fc9690",
  light_red = "#fc9487",
  light_red_soft = "#f78b7f",
  dark_green_hard = "#5a633a",
  dark_green = "#62693e",
  dark_green_soft = "#686d43",
  light_green_hard = "#d3d6a5",
  light_green = "#d5d39b",
  light_green_soft = "#cecb94",
  dark_aqua_hard = "#3e4934",
  dark_aqua = "#49503b",
  dark_aqua_soft = "#525742",
  light_aqua_hard = "#e6e9c1",
  light_aqua = "#e8e5b5",
  light_aqua_soft = "#e1dbac",
  gray = "#928374",
}

-- Get a hex list of gruvbox colors based on current bg and constrast config
local function get_colors()
  local p = Gruvbox.palette
  local config = Gruvbox.config

  for color, hex in pairs(config.palette_overrides) do
    p[color] = hex
  end

  local bg = vim.o.background
  local contrast = config.contrast

  local color_groups = {
    dark = {
      bg0 = p.dark0,
      bg1 = p.dark1,
      bg2 = p.dark2,
      bg3 = p.dark3,
      bg4 = p.dark4,
      fg0 = p.light0,
      fg1 = p.light1,
      fg2 = p.light2,
      fg3 = p.light3,
      fg4 = p.light4,
      red = p.bright_red,
      green = p.bright_green,
      yellow = p.bright_yellow,
      blue = p.bright_blue,
      purple = p.bright_purple,
      aqua = p.bright_aqua,
      orange = p.bright_orange,
      neutral_red = p.neutral_red,
      neutral_green = p.neutral_green,
      neutral_yellow = p.neutral_yellow,
      neutral_blue = p.neutral_blue,
      neutral_purple = p.neutral_purple,
      neutral_aqua = p.neutral_aqua,
      dark_red = p.dark_red,
      dark_green = p.dark_green,
      dark_aqua = p.dark_aqua,
      gray = p.gray,
    },
    light = {
      bg0 = p.light0,
      bg1 = p.light1,
      bg2 = p.light2,
      bg3 = p.light3,
      bg4 = p.light4,
      fg0 = p.dark0,
      fg1 = p.dark1,
      fg2 = p.dark2,
      fg3 = p.dark3,
      fg4 = p.dark4,
      red = p.faded_red,
      green = p.faded_green,
      yellow = p.faded_yellow,
      blue = p.faded_blue,
      purple = p.faded_purple,
      aqua = p.faded_aqua,
      orange = p.faded_orange,
      neutral_red = p.neutral_red,
      neutral_green = p.neutral_green,
      neutral_yellow = p.neutral_yellow,
      neutral_blue = p.neutral_blue,
      neutral_purple = p.neutral_purple,
      neutral_aqua = p.neutral_aqua,
      dark_red = p.light_red,
      dark_green = p.light_green,
      dark_aqua = p.light_aqua,
      gray = p.gray,
    },
  }

  if contrast ~= nil and contrast ~= "" then
    color_groups[bg].bg0 = p[bg .. "0_" .. contrast]
    color_groups[bg].dark_red = p[bg .. "_red_" .. contrast]
    color_groups[bg].dark_green = p[bg .. "_green_" .. contrast]
    color_groups[bg].dark_aqua = p[bg .. "_aqua_" .. contrast]
  end

  return color_groups[bg]
end

local function get_groups()
  local colors = get_colors()
  local config = Gruvbox.config

  if config.terminal_colors then
    local term_colors = {
      colors.bg0,
      colors.neutral_red,
      colors.neutral_green,
      colors.neutral_yellow,
      colors.neutral_blue,
      colors.neutral_purple,
      colors.neutral_aqua,
      colors.fg4,
      colors.gray,
      colors.red,
      colors.green,
      colors.yellow,
      colors.blue,
      colors.purple,
      colors.aqua,
      colors.fg1,
    }
    for index, value in ipairs(term_colors) do
      vim.g["terminal_color_" .. index - 1] = value
    end
  end

  local tweaks = {
    diff_add_bg = "#283e28",
    -- diff_add_bg = "#141f14",
    diff_change_bg = "#624604",
    -- diff_delete_bg = "#66000e",
    diff_delete_bg = "#330002",
  }

  local groups = {
    -- Colorscheme ------------------------------------------------------------
    GruvboxFg0 = { fg = colors.fg0 },
    GruvboxFg1 = { fg = colors.fg1 },
    GruvboxFg2 = { fg = colors.fg2 },
    GruvboxFg3 = { fg = colors.fg3 },
    GruvboxFg4 = { fg = colors.fg4 },
    GruvboxGray = { fg = colors.gray },
    GruvboxBg0 = { fg = colors.bg0 },
    GruvboxBg1 = { fg = colors.bg1 },
    GruvboxBg2 = { fg = colors.bg2 },
    GruvboxBg3 = { fg = colors.bg3 },
    GruvboxBg4 = { fg = colors.bg4 },
    GruvboxRed = { fg = colors.red },
    GruvboxRedBold = { fg = colors.red, bold = config.bold },
    GruvboxGreen = { fg = colors.green },
    GruvboxGreenBold = { fg = colors.green, bold = config.bold },
    GruvboxYellow = { fg = colors.yellow },
    GruvboxYellowBold = { fg = colors.yellow, bold = config.bold },
    GruvboxBlue = { fg = colors.blue },
    GruvboxBlueBold = { fg = colors.blue, bold = config.bold },
    GruvboxPurple = { fg = colors.purple },
    GruvboxPurpleBold = { fg = colors.purple, bold = config.bold },
    GruvboxAqua = { fg = colors.aqua },
    GruvboxAquaBold = { fg = colors.aqua, bold = config.bold },
    GruvboxOrange = { fg = colors.orange },
    GruvboxOrangeBold = { fg = colors.orange, bold = config.bold },
    GruvboxRedSign = config.transparent_mode and { fg = colors.red, reverse = config.invert_signs }
      or { fg = colors.red, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxGreenSign = config.transparent_mode and { fg = colors.green, reverse = config.invert_signs }
      or { fg = colors.green, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxYellowSign = config.transparent_mode and { fg = colors.yellow, reverse = config.invert_signs }
      or { fg = colors.yellow, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxBlueSign = config.transparent_mode and { fg = colors.blue, reverse = config.invert_signs }
      or { fg = colors.blue, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxPurpleSign = config.transparent_mode and { fg = colors.purple, reverse = config.invert_signs }
      or { fg = colors.purple, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxAquaSign = config.transparent_mode and { fg = colors.aqua, reverse = config.invert_signs }
      or { fg = colors.aqua, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxOrangeSign = config.transparent_mode and { fg = colors.orange, reverse = config.invert_signs }
      or { fg = colors.orange, bg = colors.bg1, reverse = config.invert_signs },
    GruvboxRedUnderline = { undercurl = config.undercurl, sp = colors.red },
    GruvboxGreenUnderline = { undercurl = config.undercurl, sp = colors.green },
    GruvboxYellowUnderline = { undercurl = config.undercurl, sp = colors.yellow },
    GruvboxBlueUnderline = { undercurl = config.undercurl, sp = colors.blue },
    GruvboxPurpleUnderline = { undercurl = config.undercurl, sp = colors.purple },
    GruvboxAquaUnderline = { undercurl = config.undercurl, sp = colors.aqua },
    GruvboxOrangeUnderline = { undercurl = config.undercurl, sp = colors.orange },

    -- Generic ----------------------------------------------------------------
    Normal = config.transparent_mode and { fg = colors.fg1, bg = nil } or { fg = colors.fg1, bg = colors.bg0 },
    NormalFloat = config.transparent_mode and { fg = colors.fg1, bg = nil } or { fg = colors.fg1, bg = colors.bg1 },
    NormalNC = config.dim_inactive and { fg = colors.fg0, bg = colors.bg1 } or { link = "Normal" },
    CursorLine = { bg = colors.bg1 },
    CursorColumn = { link = "CursorLine" },
    TabLineFill = { fg = colors.bg4, bg = colors.bg1, reverse = config.invert_tabline },
    TabLineSel = { fg = colors.green, bg = colors.bg1, reverse = config.invert_tabline },
    TabLine = { link = "TabLineFill" },
    MatchParen = { bg = colors.bg3, bold = config.bold },
    ColorColumn = { bg = colors.bg1 },
    Conceal = { fg = colors.blue },
    CursorLineNr = { fg = colors.yellow, bg = colors.bg1 },
    NonText = { link = "GruvboxBg2" },
    SpecialKey = { link = "GruvboxFg4" },
    Visual = { bg = colors.bg3, reverse = config.invert_selection },
    VisualNOS = { link = "Visual" },
    Search = { fg = colors.yellow, bg = colors.bg0, reverse = config.inverse },
    IncSearch = { fg = colors.orange, bg = colors.bg0, reverse = config.inverse },
    CurSearch = { link = "IncSearch" },
    QuickFixLine = { link = "GruvboxPurple" },
    Underlined = { fg = colors.blue, underline = config.underline },
    StatusLine = { fg = colors.fg1, bg = colors.bg2 },
    StatusLineNC = { fg = colors.fg4, bg = colors.bg1 },
    WinBar = { fg = colors.fg4, bg = colors.bg0 },
    WinBarNC = { fg = colors.fg3, bg = colors.bg1 },
    WinSeparator = config.transparent_mode and { fg = colors.bg3, bg = nil } or { fg = colors.bg3, bg = colors.bg0 },
    WildMenu = { fg = colors.blue, bg = colors.bg2, bold = config.bold },
    Directory = { link = "GruvboxGreenBold" },
    Title = { link = "GruvboxGreenBold" },
    ErrorMsg = { fg = colors.bg0, bg = colors.red, bold = config.bold },
    MoreMsg = { link = "GruvboxYellowBold" },
    ModeMsg = { link = "GruvboxYellowBold" },
    Question = { link = "GruvboxOrangeBold" },
    WarningMsg = { link = "GruvboxRedBold" },
    LineNr = { fg = colors.bg4 },
    SignColumn = config.transparent_mode and { bg = nil } or { bg = colors.bg1 },
    Folded = { fg = colors.gray, bg = colors.bg1, italic = config.italic.folds },
    FoldColumn = config.transparent_mode and { fg = colors.gray, bg = nil } or { fg = colors.gray, bg = colors.bg1 },
    Cursor = { reverse = config.inverse },
    vCursor = { link = "Cursor" },
    iCursor = { link = "Cursor" },
    lCursor = { link = "Cursor" },
    Special = { link = "GruvboxOrange" },
    Comment = { fg = colors.gray, italic = config.italic.comments },
    Todo = { fg = colors.bg0, bg = colors.yellow, bold = config.bold, italic = config.italic.comments },
    Done = { fg = colors.orange, bold = config.bold, italic = config.italic.comments },
    Error = { fg = colors.red, bold = config.bold, reverse = config.inverse },
    Statement = { link = "GruvboxRed" },
    Conditional = { link = "GruvboxRed" },
    Repeat = { link = "GruvboxRed" },
    Label = { link = "GruvboxRed" },
    Exception = { link = "GruvboxRed" },
    Operator = { fg = colors.orange, italic = config.italic.operators },
    Keyword = { link = "GruvboxRed" },
    Identifier = { link = "GruvboxFg1" },
    Function = { link = "GruvboxGreenBold" },
    PreProc = { link = "GruvboxAqua" },
    Include = { link = "GruvboxAqua" },
    Define = { link = "GruvboxAqua" },
    Macro = { link = "GruvboxAqua" },
    PreCondit = { link = "GruvboxAqua" },
    Constant = { link = "GruvboxPurple" },
    Character = { link = "GruvboxPurple" },
    String = { fg = colors.green, italic = config.italic.strings },
    Boolean = { link = "GruvboxPurple" },
    Number = { link = "GruvboxPurple" },
    Float = { link = "GruvboxPurple" },
    Type = { link = "GruvboxBlue" },
    StorageClass = { link = "GruvboxYellow" },
    Structure = { link = "GruvboxRed" },
    Typedef = { link = "GruvboxBlue" },
    Pmenu = { fg = colors.fg1, bg = colors.bg2 },
    PmenuSel = { fg = colors.bg2, bg = colors.blue, bold = config.bold },
    PmenuSbar = { bg = colors.bg2 },
    PmenuThumb = { bg = colors.bg4 },
    DiffAdd = { bg = tweaks.diff_add_bg },
    DiffChange = { bg = tweaks.diff_change_bg },
    DiffDelete = { bg = tweaks.diff_delete_bg },
    DiffText = { fg = colors.bg0, bg = colors.yellow },
    Added = { link = "DiffAdd" },
    Changed = { link = "DiffChange" },
    Removed = { link = "DiffDelete" },
    SpellCap = { link = "GruvboxBlueUnderline" },
    SpellBad = { link = "GruvboxRedUnderline" },
    SpellLocal = { link = "GruvboxAquaUnderline" },
    SpellRare = { link = "GruvboxPurpleUnderline" },
    Whitespace = { fg = colors.bg2 },
    Delimiter = { link = "GruvboxOrange" },
    EndOfBuffer = { link = "NonText" },
    DiagnosticError = { link = "GruvboxRed" },
    DiagnosticWarn = { link = "GruvboxYellow" },
    DiagnosticInfo = { link = "GruvboxBlue" },
    DiagnosticDeprecated = { link = "GruvboxYellow", strikethrough = config.strikethrough },
    DiagnosticHint = { link = "GruvboxAqua" },
    DiagnosticOk = { link = "GruvboxGreen" },
    DiagnosticSignError = { link = "GruvboxRedSign" },
    DiagnosticSignWarn = { link = "GruvboxYellowSign" },
    DiagnosticSignInfo = { link = "GruvboxBlueSign" },
    DiagnosticSignHint = { link = "GruvboxAquaSign" },
    DiagnosticSignOk = { link = "GruvboxGreenSign" },
    DiagnosticUnderlineError = { link = "GruvboxRedUnderline" },
    DiagnosticUnderlineWarn = { link = "GruvboxYellowUnderline" },
    DiagnosticUnderlineInfo = { link = "GruvboxBlueUnderline" },
    DiagnosticUnderlineHint = { link = "GruvboxAquaUnderline" },
    DiagnosticUnderlineOk = { link = "GruvboxGreenUnderline" },
    DiagnosticFloatingError = { link = "GruvboxRed" },
    DiagnosticFloatingWarn = { link = "GruvboxOrange" },
    DiagnosticFloatingInfo = { link = "GruvboxBlue" },
    DiagnosticFloatingHint = { link = "GruvboxAqua" },
    DiagnosticFloatingOk = { link = "GruvboxGreen" },
    DiagnosticVirtualTextError = { link = "GruvboxRed" },
    DiagnosticVirtualTextWarn = { link = "GruvboxYellow" },
    DiagnosticVirtualTextInfo = { link = "GruvboxBlue" },
    DiagnosticVirtualTextHint = { link = "GruvboxAqua" },
    DiagnosticVirtualTextOk = { link = "GruvboxGreen" },

    -- Filetype ---------------------------------------------------------------
    xmlTag = { link = "GruvboxOrange" },
    xmlTagName = { link = "GruvboxOrange" },

    -- Treesitter -------------------------------------------------------------
    ["@none"] = { bg = "NONE", fg = "NONE" },
    ["@comment"] = { link = "Comment" },
    ["@preproc"] = { link = "PreProc" },
    ["@define"] = { link = "Define" },
    ["@operator"] = { link = "Operator" },
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@punctuation.bracket"] = { link = "Delimiter" },
    ["@punctuation.special"] = { link = "Delimiter" },
    ["@string"] = { link = "String" },
    ["@string.regexp"] = { link = "String" },
    ["@string.escape"] = { link = "SpecialChar" },
    ["@string.special"] = { link = "SpecialChar" },
    ["@string.special.path"] = { link = "Underlined" },
    ["@string.special.symbol"] = { link = "Identifier" },
    ["@string.special.url"] = { link = "Underlined" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Float" },
    ["@float"] = { link = "Float" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Special" },
    ["@function.call"] = { link = "Function" },
    ["@function.macro"] = { link = "Macro" },
    ["@function.method"] = { link = "Function" },
    ["@method"] = { link = "Function" },
    ["@method.call"] = { link = "Function" },
    ["@constructor"] = { link = "Special" },
    ["@parameter"] = { link = "Identifier" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@keyword.debug"] = { link = "Debug" },
    ["@keyword.directive"] = { link = "PreProc" },
    ["@keyword.directive.define"] = { link = "Define" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.modifier"] = { link = "StorageClass" },
    ["@keyword.operator"] = { link = "Operator" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.return"] = { link = "Keyword" },
    ["@keyword.storage"] = { link = "StorageClass" },
    ["@keyword.type"] = { link = "Keyword" },
    ["@conditional"] = { link = "Conditional" },
    ["@repeat"] = { link = "Repeat" },
    ["@debug"] = { link = "Debug" },
    ["@label"] = { link = "Label" },
    ["@include"] = { link = "Include" },
    ["@exception"] = { link = "Exception" },
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { link = "Type" },
    ["@type.definition"] = { link = "Typedef" },
    ["@storageclass"] = { link = "StorageClass" },
    ["@attribute"] = { link = "PreProc" },
    ["@field"] = { link = "Identifier" },
    ["@property"] = { link = "Identifier" },
    ["@variable"] = { link = "GruvboxFg1" },
    ["@variable.builtin"] = { link = "Special" },
    ["@variable.member"] = { link = "Identifier" },
    ["@variable.parameter"] = { link = "Identifier" },
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Special" },
    ["@constant.macro"] = { link = "Define" },
    ["@markup"] = { link = "GruvboxFg1" },
    ["@markup.strong"] = { bold = config.bold },
    ["@markup.italic"] = { link = "@text.emphasis" },
    ["@markup.underline"] = { underline = config.underline },
    ["@markup.strikethrough"] = { strikethrough = config.strikethrough },
    ["@markup.heading"] = { link = "Title" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.math"] = { link = "Special" },
    ["@markup.environment"] = { link = "Macro" },
    ["@markup.environment.name"] = { link = "Type" },
    ["@markup.link"] = { link = "Underlined" },
    ["@markup.link.label"] = { link = "SpecialChar" },
    ["@markup.list"] = { link = "Delimiter" },
    ["@markup.list.checked"] = { link = "GruvboxGreen" },
    ["@markup.list.unchecked"] = { link = "GruvboxGray" },
    ["@comment.todo"] = { link = "Todo" },
    ["@comment.note"] = { link = "SpecialComment" },
    ["@comment.warning"] = { link = "WarningMsg" },
    ["@comment.error"] = { link = "ErrorMsg" },
    ["@diff.plus"] = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.delta"] = { link = "DiffChange" },
    ["@module"] = { link = "GruvboxFg1" },
    ["@symbol"] = { link = "Identifier" },
    ["@text"] = { link = "GruvboxFg1" },
    ["@text.strong"] = { bold = config.bold },
    ["@text.emphasis"] = { italic = config.italic.emphasis },
    ["@text.underline"] = { underline = config.underline },
    ["@text.strike"] = { strikethrough = config.strikethrough },
    ["@text.title"] = { link = "Title" },
    ["@text.literal"] = { link = "String" },
    ["@text.uri"] = { link = "Underlined" },
    ["@text.math"] = { link = "Special" },
    ["@text.environment"] = { link = "Macro" },
    ["@text.environment.name"] = { link = "Type" },
    ["@text.reference"] = { link = "Constant" },
    ["@text.todo"] = { link = "Todo" },
    ["@text.todo.checked"] = { link = "GruvboxGreen" },
    ["@text.todo.unchecked"] = { link = "GruvboxGray" },
    ["@text.note"] = { link = "SpecialComment" },
    ["@text.note.comment"] = { link = "Comment" },
    ["@text.warning"] = { link = "WarningMsg" },
    ["@text.danger"] = { link = "ErrorMsg" },
    ["@text.danger.comment"] = { link = "ErrorMsg" },
    ["@text.diff.add"] = { link = "DiffAdd" },
    ["@text.diff.delete"] = { link = "DiffDelete" },
    ["@tag"] = { link = "Tag" },
    ["@tag.attribute"] = { link = "Identifier" },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@punctuation"] = { link = "Delimiter" },
    ["@macro"] = { link = "Macro" },
    ["@structure"] = { link = "Structure" },

    -- LSP --------------------------------------------------------------------
    LspReferenceRead = { link = "GruvboxYellowBold" },
    LspReferenceTarget = { link = "Visual" },
    LspReferenceText = { link = "GruvboxYellowBold" },
    LspReferenceWrite = { link = "GruvboxOrangeBold" },
    LspCodeLens = { link = "GruvboxGray" },
    LspSignatureActiveParameter = { link = "Search" },
    LspInlayHint = { link = "Comment" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@macro" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@constructor" },
    ["@lsp.type.macro"] = { link = "@macro" },
    ["@lsp.type.method"] = { link = "@method" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type.definition" },
    ["@lsp.type.variable"] = { link = "@variable" },

    -- Plugins ----------------------------------------------------------------
    GitSignsAdd = { link = "GruvboxGreen" },
    GitSignsChange = { link = "GruvboxOrange" },
    GitSignsDelete = { link = "GruvboxRed" },
    TelescopeNormal = { link = "GruvboxFg1" },
    TelescopeSelection = { link = "CursorLine" },
    TelescopeSelectionCaret = { link = "GruvboxRed" },
    TelescopeMultiSelection = { link = "GruvboxGray" },
    TelescopeBorder = { link = "TelescopeNormal" },
    TelescopePromptBorder = { link = "TelescopeNormal" },
    TelescopeResultsBorder = { link = "TelescopeNormal" },
    TelescopePreviewBorder = { link = "TelescopeNormal" },
    TelescopeMatching = { link = "GruvboxOrange" },
    TelescopePromptPrefix = { link = "GruvboxRed" },
    TelescopePrompt = { link = "TelescopeNormal" },
    NoiceCursor = { link = "TermCursor" },
    NoiceCmdlinePopupBorder = { link = "GruvboxBlue" },
    NoiceCmdlineIcon = { link = "NoiceCmdlinePopupBorder" },
    NoiceConfirmBorder = { link = "NoiceCmdlinePopupBorder" },
    NoiceCmdlinePopupBorderSearch = { link = "GruvboxYellow" },
    NoiceCmdlineIconSearch = { link = "NoiceCmdlinePopupBorderSearch" },
    NotifyDEBUGBorder = { link = "GruvboxBlue" },
    NotifyDEBUGIcon = { link = "GruvboxBlue" },
    NotifyDEBUGTitle = { link = "GruvboxBlue" },
    NotifyERRORBorder = { link = "GruvboxRed" },
    NotifyERRORIcon = { link = "GruvboxRed" },
    NotifyERRORTitle = { link = "GruvboxRed" },
    NotifyINFOBorder = { link = "GruvboxAqua" },
    NotifyINFOIcon = { link = "GruvboxAqua" },
    NotifyINFOTitle = { link = "GruvboxAqua" },
    NotifyTRACEBorder = { link = "GruvboxGreen" },
    NotifyTRACEIcon = { link = "GruvboxGreen" },
    NotifyTRACETitle = { link = "GruvboxGreen" },
    NotifyWARNBorder = { link = "GruvboxYellow" },
    NotifyWARNIcon = { link = "GruvboxYellow" },
    NotifyWARNTitle = { link = "GruvboxYellow" },
  }

  for group, hl in pairs(config.overrides) do
    if groups[group] then
      -- "link" should not mix with other configs (:h hi-link)
      groups[group].link = nil
    end

    groups[group] = vim.tbl_extend("force", groups[group] or {}, hl)
  end

  return groups
end

---@param config GruvboxConfig?
Gruvbox.setup = function(config)
  Gruvbox.config = vim.deepcopy(default_config)
  Gruvbox.config = vim.tbl_deep_extend("force", Gruvbox.config, config or {})
end

--- Main load function
Gruvbox.load = function()
  if vim.version().minor < 8 then
    vim.notify_once("gruvbox.nvim: you must use neovim 0.8 or higher")
    return
  end

  -- Reset colors
  if vim.g.colors_name then
    vim.cmd.hi("clear")
  end
  vim.g.colors_name = "gruvbox"
  vim.o.termguicolors = true

  local groups = get_groups()

  -- Add highlights
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return Gruvbox
