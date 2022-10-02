--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl
local home = os.getenv('HOME')

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function colors(i)
    local lines = lines_from(home .. '/.cache/wal/colors')
    return hsl(lines[i])
end

local palette = {}

palette.dark = {
    grays = {
        bg     = colors(1);
        overbg = colors(1).lighten(5).desaturate(100);
        sel    = colors(8).darken(55).desaturate(100);
        com    = colors(8).darken(30).desaturate(100);
        faded  = colors(8).darken(15).desaturate(100);
        fg     = colors(8);
    };

    shades = {
        red     = colors(2).darken(20);
        green   = colors(3).darken(20);
        yellow  = colors(4).darken(20);
        cyan    = colors(5).darken(20);
        blue    = colors(6).darken(20);
        magenta = colors(7).darken(20);
    };

    tones = {
        red     = colors(2);
        green   = colors(3);
        yellow  = colors(4);
        cyan    = colors(5);
        blue    = colors(6);
        magenta = colors(7);
    };

    tints = {
        red     = colors(2).lighten(20);
        yellow  = colors(3).lighten(20);
        green   = colors(4).lighten(20);
        cyan    = colors(5).lighten(20);
        blue    = colors(6).lighten(20);
        magenta = colors(7).lighten(20);
    };
}

local bg = vim.opt.background:get()
local g = palette[bg].grays
local c = palette[bg].tones

local d, b;  --TODO: Rename
d = palette[bg].shades
b = palette[bg].tints


-- Font variants:
-- This only works when loading this file directly, not when loading with `:colorscheme`
local bf, it, underline, undercurl;
bf = "bold"
it = "italic"
underline = "underline"
undercurl = "undercurl"

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function()
  return {
---- :help highlight-default -------------------------------

Normal       { fg=g.fg };
NormalFloat  { bg=g.overbg };
-- NormalNC     { };

Cursor       { fg=g.bg,bg=b.blue};
-- lCursor      { };
-- CursorIM     { };
-- TermCursor   { };
-- TermCursorNC { };

ColorColumn  { bg=g.overbg };
CursorColumn { ColorColumn };
CursorLine   { ColorColumn };
VertSplit    { fg=g.sel };

LineNr       { fg=g.sel };
CursorLineNr { fg=c.yellow };

Folded       { fg=g.com, bg=g.overbg };
FoldColumn   { LineNr };
SignColumn   { LineNr };

Pmenu        { bg = g.overbg };
PmenuSel     { bg=g.sel };
PmenuSbar    { Pmenu };
PmenuThumb   { PmenuSel };

StatusLine   { NormalFloat };
StatusLineNC { StatusLine, fg=g.faded };
WildMenu     { NormalFloat };

TabLine      { StatusLineNC };
TabLineFill  { StatusLine };
TabLineSel   { StatusLine, gui=bf };

MatchParen   { fg=b.yellow, bg=g.sel, gui=bf };
Substitute   { fg=g.bg, bg=d.yellow };
Search       { fg=g.bg, bg=d.yellow };
-- QuickFixLine { };
-- IncSearch    { };
Visual       { bg=g.sel };
-- VisualNOS    { };

Conceal      { fg=g.faded };
Whitespace   { fg=g.sel };
EndOfBuffer  { Whitespace };
NonText      { Whitespace };
SpecialKey   { Whitespace };

Directory    { fg=c.cyan };
Title        { fg=c.yellow };
ErrorMsg     { bg=d.red };
ModeMsg      { fg=g.faded };
-- MsgArea      { };
-- MsgSeparator { };
MoreMsg      { fg=c.green, gui=bf };
WarningMsg   { fg=c.red };
Question     { MoreMsg };


---- :help :diff -------------------------------------------

DiffAdd      { fg=d.green };
DiffChange   { fg=d.magenta };
DiffDelete   { fg=d.red };
DiffText     { fg=d.blue };

DiffAdded    { DiffAdd };
DiffRemoved  { DiffDelete };


---- :help spell -------------------------------------------

SpellBad     { fg=c.red,    gui=undercurl };
SpellCap     { fg=c.blue,   gui=undercurl };
SpellLocal   { fg=c.yellow, gui=undercurl };
SpellRare    { fg=b.yellow, gui=undercurl };


---- :help group-name --------------------------------------

Comment        { fg=g.com, gui=it };
Identifier     { fg=c.red };
Function       { fg=b.yellow };

Constant       { fg=c.green };
String         { fg=b.blue};
Character      { fg=b.blue };
Number         { fg=b.green };
Boolean        { fg=b.green, gui=bf };
-- Float          { };

Statement      { fg=c.red };
-- Conditional    { };
-- Repeat         { };
-- Label          { };
Operator       { fg=b.yellow };
-- Keyword        { };
-- Exception      { };

PreProc        { fg=b.green };
-- Include        { };
-- Define         { };
-- Macro          { };
-- PreCondit      { };

Type           { fg=c.blue };
-- StorageClass   { };
-- Structure      { };
-- Typedef        { };

Special        { fg=b.yellow };
-- SpecialChar    { };
-- Tag            { };
Delimiter      { fg=d.yellow };
-- SpecialComment { };
-- Debug          { };

Underlined     { gui=underline };
Bold           { gui=bf };
Italic         { gui=it };

Ignore         { fg=g.com };
Error          { bg=d.red };
Todo           { Comment, fg=g.faded };


---- :help nvim-treesitter-highlights (external plugin) ----

-- TSAnnotation         { };
-- TSAttribute          { };
-- TSBoolean            { };
-- TSCharacter          { };
-- TSComment            { };
-- TSConditional        { };
-- TSConstant           { };
TSConstBuiltin       { Constant, gui=it };
TSConstMacro         { Constant };
-- TSConstructor        { };
-- TSError              { gui=undercurl };
-- TSException          { };
-- TSField              { };
-- TSFloat              { };
-- TSFunction           { };
TSFuncBuiltin        { Function };
TSFuncMacro          { Function };
-- TSInclude            { };
-- TSKeyword            { };
TSKeywordFunction    { PreProc };
-- TSKeywordOperator    { };
-- TSKeywordReturn      { };
-- TSLabel              { };
-- TSMethod             { };
TSNamespace          { fg=c.green };
-- TSNone               { };
-- TSNumber             { };
-- TSOperator           { };
-- TSParameter          { };
-- TSParameterReference { };
-- TSProperty           { };
TSPunctDelimiter     { fg=c.red };
TSPunctBracket       { Delimiter };
TSPunctSpecial       { Delimiter };
-- TSRepeat             { };
-- TSString             { };
-- TSStringRegex        { };
TSStringEscape       { fg=c.blue };
TSSymbol             { Identifier, gui=it };
-- TSType               { };
-- TSTypeBuiltin        { };
TSVariable           { Identifier };
TSVariableBuiltin    { Identifier, gui=it };

-- TSTag                { };
-- TSTagDelimiter       { };
-- TSText               { };
TSStrong             { gui=bf };
TSEmphasis           { Italic };
TSUnderline          { Underlined };
TSStrike             { gui="strikethrough" };
-- TSTitle              { };
-- TSLiteral            { };
TSURI                { String, gui=underline };
TSMath               { fg=b.cyan };
-- TSTextReference      { };
TSEnvironment        { Statement };
TSEnvironmentName    { PreProc };
-- TSNote               { };
-- TSWarning            { };
-- TSDanger             { };


---- :help lsp-highlight -----------------------------------

LspReferenceText                     { Visual };
LspReferenceRead                     { Visual };
LspReferenceWrite                    { Visual };

LspDiagnosticsDefaultError           { fg=c.red };
LspDiagnosticsDefaultWarning         { fg=b.yellow };
LspDiagnosticsDefaultInformation     { fg=b.blue };
LspDiagnosticsDefaultHint            { fg=c.green};

-- LspDiagnosticsVirtualTextError       { };
-- LspDiagnosticsVirtualTextWarning     { };
-- LspDiagnosticsVirtualTextInformation { };
-- LspDiagnosticsVirtualTextHint        { };

LspDiagnosticsUnderlineError         { sp="red",gui=undercurl};
LspDiagnosticsUnderlineWarning       { gui=undercurl };
LspDiagnosticsUnderlineInformation   { gui=undercurl };
LspDiagnosticsUnderlineHint          { gui=undercurl };

-- LspDiagnosticsFloatingError          { };
-- LspDiagnosticsFloatingWarning        { };
-- LspDiagnosticsFloatingInformation    { };
-- LspDiagnosticsFloatingHint           { };

-- LspDiagnosticsSignError              { };
-- LspDiagnosticsSignWarning            { };
-- LspDiagnosticsSignInformation        { };
-- LspDiagnosticsSignHint               { };


--- :help vimtex-syntax-reference (external plugin) --------

texOptSep            { TSPunctDelimiter };
texOptEqual          { Operator };
texFileArg           { Constant };
texTitleArg          { gui=bf };
texRefArg            { Constant };

texMathCmd           { Function };
texMathSymbol        { Operator };
texMathZone          { TSMath };
texMathDelimZone     { TSPunctDelimiter };
texMathDelim         { Delimiter };
texMathEnvArgName    { PreProc };


--- netrw: there's no comprehensive list of highlights... --

netrwClassify        { Delimiter };
netrwTreeBar         { Delimiter };

netrwExe             { fg=c.red };
netrwSymLink         { fg=c.magenta };


---- Misc. -------------------------------------------------
HelpHyperTextJump    { fg=c.yellow };
IndentBlanklineContextChar { fg=b.red, gui="nocombine"};


---- Metagroup (hack for builds) ---------------------------
Melange { lush = palette[bg] };
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
