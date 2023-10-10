" Initialization: {{{
let s:configuration = sonokai_mini#get_configuration()
let s:palette = sonokai_mini#get_palette(s:configuration.style, s:configuration.colors_override)
let s:path = expand('<sfile>:p') " the path of this script
let s:last_modified = 'Mon Aug  7 07:21:35 UTC 2023'
let g:sonokai_mini_loaded_file_types = []

if !(exists('g:colors_name') && g:colors_name ==# 'sonokai_mini' && s:configuration.better_performance)
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'sonokai_mini'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif
" }}}
" Common Highlight Groups: {{{
" UI: {{{
if s:configuration.transparent_background >= 1
  call sonokai_mini#highlight('Normal', s:palette.fg, s:palette.none)
  call sonokai_mini#highlight('NormalNC', s:palette.fg, s:palette.none)
  call sonokai_mini#highlight('Terminal', s:palette.fg, s:palette.none)
  if s:configuration.show_eob
    call sonokai_mini#highlight('EndOfBuffer', s:palette.bg4, s:palette.none)
  else
    call sonokai_mini#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  call sonokai_mini#highlight('Folded', s:palette.grey, s:palette.none)
  call sonokai_mini#highlight('ToolbarLine', s:palette.fg, s:palette.none)
  call sonokai_mini#highlight('FoldColumn', s:palette.grey_dim, s:palette.none)
else
  call sonokai_mini#highlight('Normal', s:palette.fg, s:palette.bg0)
  if s:configuration.dim_inactive_windows
    call sonokai_mini#highlight('NormalNC', s:palette.fg, s:palette.bg_dim)
  else
    call sonokai_mini#highlight('NormalNC', s:palette.fg, s:palette.bg0)
  endif
  call sonokai_mini#highlight('Terminal', s:palette.fg, s:palette.bg0)
  if s:configuration.show_eob
    call sonokai_mini#highlight('EndOfBuffer', s:palette.bg4, s:palette.none)
  else
    call sonokai_mini#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  call sonokai_mini#highlight('Folded', s:palette.grey, s:palette.bg1)
  call sonokai_mini#highlight('ToolbarLine', s:palette.fg, s:palette.bg2)
  call sonokai_mini#highlight('FoldColumn', s:palette.grey_dim, s:palette.none)
endif
call sonokai_mini#highlight('SignColumn', s:palette.fg, s:palette.none)
call sonokai_mini#highlight('IncSearch', s:palette.bg0, s:palette.bg_red)
call sonokai_mini#highlight('Search', s:palette.bg0, s:palette.bg_green)
highlight! link CurSearch IncSearch
call sonokai_mini#highlight('ColorColumn', s:palette.none, s:palette.bg1)
call sonokai_mini#highlight('Conceal', s:palette.grey_dim, s:palette.none)
if s:configuration.cursor ==# 'auto'
  call sonokai_mini#highlight('Cursor', s:palette.none, s:palette.none, 'reverse')
else
  call sonokai_mini#highlight('Cursor', s:palette.bg0, s:palette[s:configuration.cursor])
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
if &diff
  call sonokai_mini#highlight('CursorLine', s:palette.none, s:palette.none, 'underline')
  call sonokai_mini#highlight('CursorColumn', s:palette.none, s:palette.none, 'bold')
else
  call sonokai_mini#highlight('CursorLine', s:palette.none, s:palette.bg1)
  call sonokai_mini#highlight('CursorColumn', s:palette.none, s:palette.bg1)
endif
call sonokai_mini#highlight('LineNr', s:palette.grey_dim, s:palette.none)
if &diff
  call sonokai_mini#highlight('CursorLineNr', s:palette.fg, s:palette.none, 'underline')
else
  call sonokai_mini#highlight('CursorLineNr', s:palette.fg, s:palette.none)
endif
call sonokai_mini#highlight('DiffAdd', s:palette.none, s:palette.diff_green)
call sonokai_mini#highlight('DiffChange', s:palette.none, s:palette.diff_blue)
call sonokai_mini#highlight('DiffDelete', s:palette.none, s:palette.diff_red)
call sonokai_mini#highlight('DiffText', s:palette.bg0, s:palette.blue)
call sonokai_mini#highlight('Directory', s:palette.green, s:palette.none)
call sonokai_mini#highlight('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call sonokai_mini#highlight('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call sonokai_mini#highlight('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call sonokai_mini#highlight('MoreMsg', s:palette.blue, s:palette.none, 'bold')
call sonokai_mini#highlight('MatchParen', s:palette.none, s:palette.bg4)
call sonokai_mini#highlight('NonText', s:palette.bg4, s:palette.none)
call sonokai_mini#highlight('Whitespace', s:palette.bg4, s:palette.none)
call sonokai_mini#highlight('SpecialKey', s:palette.bg4, s:palette.none)
call sonokai_mini#highlight('Pmenu', s:palette.fg, s:palette.bg2)
call sonokai_mini#highlight('PmenuSbar', s:palette.none, s:palette.bg2)
if s:configuration.menu_selection_background ==# 'blue'
  call sonokai_mini#highlight('PmenuSel', s:palette.bg0, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
  call sonokai_mini#highlight('PmenuSel', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
  call sonokai_mini#highlight('PmenuSel', s:palette.bg0, s:palette.bg_red)
endif
call sonokai_mini#highlight('PmenuKind', s:palette.green, s:palette.bg2)
call sonokai_mini#highlight('PmenuExtra', s:palette.grey, s:palette.bg2)
highlight! link WildMenu PmenuSel
call sonokai_mini#highlight('PmenuThumb', s:palette.none, s:palette.grey)
if s:configuration.float_style ==# 'dim'
  call sonokai_mini#highlight('NormalFloat', s:palette.fg, s:palette.bg_dim)
  call sonokai_mini#highlight('FloatBorder', s:palette.grey, s:palette.bg_dim)
else
  call sonokai_mini#highlight('NormalFloat', s:palette.fg, s:palette.bg2)
  call sonokai_mini#highlight('FloatBorder', s:palette.grey, s:palette.bg2)
endif
call sonokai_mini#highlight('Question', s:palette.yellow, s:palette.none)
if s:configuration.spell_foreground ==# 'none'
  call sonokai_mini#highlight('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call sonokai_mini#highlight('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call sonokai_mini#highlight('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call sonokai_mini#highlight('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
else
  call sonokai_mini#highlight('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
  call sonokai_mini#highlight('SpellCap', s:palette.yellow, s:palette.none, 'undercurl', s:palette.yellow)
  call sonokai_mini#highlight('SpellLocal', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
  call sonokai_mini#highlight('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
endif
if s:configuration.transparent_background == 2
  call sonokai_mini#highlight('StatusLine', s:palette.fg, s:palette.none)
  call sonokai_mini#highlight('StatusLineTerm', s:palette.fg, s:palette.none)
  call sonokai_mini#highlight('StatusLineNC', s:palette.grey, s:palette.none)
  call sonokai_mini#highlight('StatusLineTermNC', s:palette.grey, s:palette.none)
  call sonokai_mini#highlight('TabLine', s:palette.fg, s:palette.bg4)
  call sonokai_mini#highlight('TabLineFill', s:palette.grey, s:palette.none)
  call sonokai_mini#highlight('TabLineSel', s:palette.bg0, s:palette.bg_red)
else
  call sonokai_mini#highlight('StatusLine', s:palette.fg, s:palette.bg3)
  call sonokai_mini#highlight('StatusLineTerm', s:palette.fg, s:palette.bg3)
  call sonokai_mini#highlight('StatusLineNC', s:palette.grey, s:palette.bg1)
  call sonokai_mini#highlight('StatusLineTermNC', s:palette.grey, s:palette.bg1)
  call sonokai_mini#highlight('TabLine', s:palette.fg, s:palette.bg4)
  call sonokai_mini#highlight('TabLineFill', s:palette.grey, s:palette.bg1)
  call sonokai_mini#highlight('TabLineSel', s:palette.bg0, s:palette.bg_red)
endif
if s:configuration.dim_inactive_windows
  call sonokai_mini#highlight('VertSplit', s:palette.bg4, s:palette.bg_dim)
else
  call sonokai_mini#highlight('VertSplit', s:palette.black, s:palette.none)
endif
highlight! link WinSeparator VertSplit
call sonokai_mini#highlight('Visual', s:palette.none, s:palette.bg3)
call sonokai_mini#highlight('VisualNOS', s:palette.none, s:palette.bg3, 'underline')
call sonokai_mini#highlight('QuickFixLine', s:palette.blue, s:palette.none, 'bold')
call sonokai_mini#highlight('Debug', s:palette.yellow, s:palette.none)
call sonokai_mini#highlight('debugPC', s:palette.bg0, s:palette.green)
call sonokai_mini#highlight('debugBreakpoint', s:palette.bg0, s:palette.red)
call sonokai_mini#highlight('ToolbarButton', s:palette.bg0, s:palette.bg_blue)
if has('nvim')
  call sonokai_mini#highlight('Substitute', s:palette.bg0, s:palette.yellow)
  highlight! link WinBarNC Grey
  highlight! link DiagnosticFloatingError ErrorFloat
  highlight! link DiagnosticFloatingWarn WarningFloat
  highlight! link DiagnosticFloatingInfo InfoFloat
  highlight! link DiagnosticFloatingHint HintFloat
  highlight! link DiagnosticError ErrorText
  highlight! link DiagnosticWarn WarningText
  highlight! link DiagnosticInfo InfoText
  highlight! link DiagnosticHint HintText
  highlight! link DiagnosticVirtualTextError VirtualTextError
  highlight! link DiagnosticVirtualTextWarn VirtualTextWarning
  highlight! link DiagnosticVirtualTextInfo VirtualTextInfo
  highlight! link DiagnosticVirtualTextHint VirtualTextHint
  highlight! link DiagnosticUnderlineError ErrorText
  highlight! link DiagnosticUnderlineWarn WarningText
  highlight! link DiagnosticUnderlineInfo InfoText
  highlight! link DiagnosticUnderlineHint HintText
  highlight! link DiagnosticSignError RedSign
  highlight! link DiagnosticSignWarn YellowSign
  highlight! link DiagnosticSignInfo BlueSign
  highlight! link DiagnosticSignHint GreenSign
  highlight! link LspDiagnosticsFloatingError DiagnosticFloatingError
  highlight! link LspDiagnosticsFloatingWarning DiagnosticFloatingWarn
  highlight! link LspDiagnosticsFloatingInformation DiagnosticFloatingInfo
  highlight! link LspDiagnosticsFloatingHint DiagnosticFloatingHint
  highlight! link LspDiagnosticsDefaultError DiagnosticError
  highlight! link LspDiagnosticsDefaultWarning DiagnosticWarn
  highlight! link LspDiagnosticsDefaultInformation DiagnosticInfo
  highlight! link LspDiagnosticsDefaultHint DiagnosticHint
  highlight! link LspDiagnosticsVirtualTextError DiagnosticVirtualTextError
  highlight! link LspDiagnosticsVirtualTextWarning DiagnosticVirtualTextWarn
  highlight! link LspDiagnosticsVirtualTextInformation DiagnosticVirtualTextInfo
  highlight! link LspDiagnosticsVirtualTextHint DiagnosticVirtualTextHint
  highlight! link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  highlight! link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  highlight! link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  highlight! link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  highlight! link LspDiagnosticsSignError DiagnosticSignError
  highlight! link LspDiagnosticsSignWarning DiagnosticSignWarn
  highlight! link LspDiagnosticsSignInformation DiagnosticSignInfo
  highlight! link LspDiagnosticsSignHint DiagnosticSignHint
  highlight! link LspReferenceText CurrentWord
  highlight! link LspReferenceRead CurrentWord
  highlight! link LspReferenceWrite CurrentWord
  highlight! link LspCodeLens VirtualTextInfo
  highlight! link LspCodeLensSeparator VirtualTextHint
  highlight! link LspSignatureActiveParameter Search
  highlight! link TermCursor Cursor
  highlight! link healthError Red
  highlight! link healthSuccess Green
  highlight! link healthWarning Yellow
endif
" }}}
" Syntax: {{{
if s:configuration.enable_italic
  call sonokai_mini#highlight('Type', s:palette.blue, s:palette.none, 'italic')
  call sonokai_mini#highlight('Structure', s:palette.blue, s:palette.none, 'italic')
  call sonokai_mini#highlight('StorageClass', s:palette.blue, s:palette.none, 'italic')
  call sonokai_mini#highlight('Identifier', s:palette.orange, s:palette.none, 'italic')
  call sonokai_mini#highlight('Constant', s:palette.orange, s:palette.none, 'italic')
else
  call sonokai_mini#highlight('Type', s:palette.blue, s:palette.none)
  call sonokai_mini#highlight('Structure', s:palette.blue, s:palette.none)
  call sonokai_mini#highlight('StorageClass', s:palette.blue, s:palette.none)
  call sonokai_mini#highlight('Identifier', s:palette.orange, s:palette.none)
  call sonokai_mini#highlight('Constant', s:palette.orange, s:palette.none)
endif
call sonokai_mini#highlight('PreProc', s:palette.red, s:palette.none)
call sonokai_mini#highlight('PreCondit', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Include', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Keyword', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Define', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Typedef', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Exception', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Conditional', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Repeat', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Statement', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Macro', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('Error', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Label', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('Special', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('SpecialChar', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('Boolean', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('String', s:palette.yellow, s:palette.none)
call sonokai_mini#highlight('Character', s:palette.yellow, s:palette.none)
call sonokai_mini#highlight('Number', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('Float', s:palette.purple, s:palette.none)
call sonokai_mini#highlight('Function', s:palette.green, s:palette.none)
call sonokai_mini#highlight('Operator', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Title', s:palette.red, s:palette.none, 'bold')
call sonokai_mini#highlight('Tag', s:palette.orange, s:palette.none)
call sonokai_mini#highlight('Delimiter', s:palette.fg, s:palette.none)
call sonokai_mini#highlight('Todo', s:palette.bg0, s:palette.blue, 'bold')
if s:configuration.disable_italic_comment
  call sonokai_mini#highlight('Comment', s:palette.grey, s:palette.none)
  call sonokai_mini#highlight('SpecialComment', s:palette.grey, s:palette.none)
else
  call sonokai_mini#highlight('Comment', s:palette.grey, s:palette.none, 'italic')
  call sonokai_mini#highlight('SpecialComment', s:palette.grey, s:palette.none, 'italic')
endif
call sonokai_mini#highlight('Ignore', s:palette.grey, s:palette.none)
call sonokai_mini#highlight('Underlined', s:palette.none, s:palette.none, 'underline')
" }}}
" Predefined Highlight Groups: {{{
call sonokai_mini#highlight('Fg', s:palette.fg, s:palette.none)
call sonokai_mini#highlight('Grey', s:palette.grey, s:palette.none)
call sonokai_mini#highlight('Red', s:palette.red, s:palette.none)
call sonokai_mini#highlight('Orange', s:palette.orange, s:palette.none)
call sonokai_mini#highlight('Yellow', s:palette.yellow, s:palette.none)
call sonokai_mini#highlight('Green', s:palette.green, s:palette.none)
call sonokai_mini#highlight('Blue', s:palette.blue, s:palette.none)
call sonokai_mini#highlight('Purple', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call sonokai_mini#highlight('RedItalic', s:palette.red, s:palette.none, 'italic')
  call sonokai_mini#highlight('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
  call sonokai_mini#highlight('YellowItalic', s:palette.yellow, s:palette.none, 'italic')
  call sonokai_mini#highlight('GreenItalic', s:palette.green, s:palette.none, 'italic')
  call sonokai_mini#highlight('BlueItalic', s:palette.blue, s:palette.none, 'italic')
  call sonokai_mini#highlight('PurpleItalic', s:palette.purple, s:palette.none, 'italic')
else
  call sonokai_mini#highlight('RedItalic', s:palette.red, s:palette.none)
  call sonokai_mini#highlight('OrangeItalic', s:palette.orange, s:palette.none)
  call sonokai_mini#highlight('YellowItalic', s:palette.yellow, s:palette.none)
  call sonokai_mini#highlight('GreenItalic', s:palette.green, s:palette.none)
  call sonokai_mini#highlight('BlueItalic', s:palette.blue, s:palette.none)
  call sonokai_mini#highlight('PurpleItalic', s:palette.purple, s:palette.none)
endif
call sonokai_mini#highlight('RedSign', s:palette.red, s:palette.none)
call sonokai_mini#highlight('OrangeSign', s:palette.orange, s:palette.none)
call sonokai_mini#highlight('YellowSign', s:palette.yellow, s:palette.none)
call sonokai_mini#highlight('GreenSign', s:palette.green, s:palette.none)
call sonokai_mini#highlight('BlueSign', s:palette.blue, s:palette.none)
call sonokai_mini#highlight('PurpleSign', s:palette.purple, s:palette.none)
if s:configuration.diagnostic_text_highlight
  call sonokai_mini#highlight('ErrorText', s:palette.none, s:palette.diff_red, 'undercurl', s:palette.red)
  call sonokai_mini#highlight('WarningText', s:palette.none, s:palette.diff_yellow, 'undercurl', s:palette.yellow)
  call sonokai_mini#highlight('InfoText', s:palette.none, s:palette.diff_blue, 'undercurl', s:palette.blue)
  call sonokai_mini#highlight('HintText', s:palette.none, s:palette.diff_green, 'undercurl', s:palette.green)
else
  call sonokai_mini#highlight('ErrorText', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call sonokai_mini#highlight('WarningText', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call sonokai_mini#highlight('InfoText', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call sonokai_mini#highlight('HintText', s:palette.none, s:palette.none, 'undercurl', s:palette.green)
endif
if s:configuration.diagnostic_line_highlight
  call sonokai_mini#highlight('ErrorLine', s:palette.none, s:palette.diff_red)
  call sonokai_mini#highlight('WarningLine', s:palette.none, s:palette.diff_yellow)
  call sonokai_mini#highlight('InfoLine', s:palette.none, s:palette.diff_blue)
  call sonokai_mini#highlight('HintLine', s:palette.none, s:palette.diff_green)
else
  highlight clear ErrorLine
  highlight clear WarningLine
  highlight clear InfoLine
  highlight clear HintLine
endif
if s:configuration.diagnostic_virtual_text ==# 'grey'
  highlight! link VirtualTextWarning Grey
  highlight! link VirtualTextError Grey
  highlight! link VirtualTextInfo Grey
  highlight! link VirtualTextHint Grey
elseif s:configuration.diagnostic_virtual_text ==# 'colored'
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextError Red
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
else
  call sonokai_mini#highlight('VirtualTextWarning', s:palette.yellow, s:palette.diff_yellow)
  call sonokai_mini#highlight('VirtualTextError', s:palette.red, s:palette.diff_red)
  call sonokai_mini#highlight('VirtualTextInfo', s:palette.blue, s:palette.diff_blue)
  call sonokai_mini#highlight('VirtualTextHint', s:palette.green, s:palette.diff_green)
endif
call sonokai_mini#highlight('ErrorFloat', s:palette.red, s:palette.none)
call sonokai_mini#highlight('WarningFloat', s:palette.yellow, s:palette.none)
call sonokai_mini#highlight('InfoFloat', s:palette.blue, s:palette.none)
call sonokai_mini#highlight('HintFloat', s:palette.green, s:palette.none)
if &diff
  call sonokai_mini#highlight('CurrentWord', s:palette.bg0, s:palette.green)
elseif s:configuration.current_word ==# 'grey background'
  call sonokai_mini#highlight('CurrentWord', s:palette.none, s:palette.bg2)
else
  call sonokai_mini#highlight('CurrentWord', s:palette.none, s:palette.none, s:configuration.current_word)
endif
" Define a color for each LSP item kind to create highlights for nvim-cmp, aerial.nvim, nvim-navic and coc.nvim
let g:sonokai_mini_lsp_kind_color = [
      \ ["Array", "Yellow"],
      \ ["Boolean", "Yellow"],
      \ ["Class", "Blue"],
      \ ["Color", "Yellow"],
      \ ["Constant", "Orange"],
      \ ["Constructor", "Green"],
      \ ["Default", "Yellow"],
      \ ["Enum", "Blue"],
      \ ["EnumMember", "Purple"],
      \ ["Event", "Yellow"],
      \ ["Field", "Green"],
      \ ["File", "Green"],
      \ ["Folder", "Yellow"],
      \ ["Function", "Green"],
      \ ["Interface", "Blue"],
      \ ["Key", "Red"],
      \ ["Keyword", "Red"],
      \ ["Method", "Green"],
      \ ["Module", "Blue"],
      \ ["Namespace", "Red"],
      \ ["Null", "Yellow"],
      \ ["Number", "Yellow"],
      \ ["Object", "Yellow"],
      \ ["Operator", "Red"],
      \ ["Package", "Red"],
      \ ["Property", "Orange"],
      \ ["Reference", "Yellow"],
      \ ["Snippet", "Yellow"],
      \ ["String", "Yellow"],
      \ ["Struct", "Blue"],
      \ ["Text", "Fg"],
      \ ["TypeParameter", "Blue"],
      \ ["Unit", "Purple"],
      \ ["Value", "Purple"],
      \ ["Variable", "Orange"],
      \ ]
" }}}
" }}}
" Terminal: {{{
if ((has('termguicolors') && &termguicolors) || has('gui_running')) && !s:configuration.disable_terminal_colors
  " Definition
  let s:terminal = {
        \ 'black':           s:palette.black,
        \ 'red':             s:palette.red,
        \ 'yellow':          s:palette.yellow,
        \ 'green':           s:palette.green,
        \ 'cyan':            s:palette.orange,
        \ 'blue':            s:palette.blue,
        \ 'purple':          s:palette.purple,
        \ 'white':           s:palette.fg,
        \ 'bright_black':    s:palette.grey,
        \ }
  " Implementation: {{{
  if !has('nvim')
    let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
          \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
          \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]
  else
    let g:terminal_color_0 = s:terminal.black[0]
    let g:terminal_color_1 = s:terminal.red[0]
    let g:terminal_color_2 = s:terminal.green[0]
    let g:terminal_color_3 = s:terminal.yellow[0]
    let g:terminal_color_4 = s:terminal.blue[0]
    let g:terminal_color_5 = s:terminal.purple[0]
    let g:terminal_color_6 = s:terminal.cyan[0]
    let g:terminal_color_7 = s:terminal.white[0]
    let g:terminal_color_8 = s:terminal.bright_black[0]
    let g:terminal_color_9 = s:terminal.red[0]
    let g:terminal_color_10 = s:terminal.green[0]
    let g:terminal_color_11 = s:terminal.yellow[0]
    let g:terminal_color_12 = s:terminal.blue[0]
    let g:terminal_color_13 = s:terminal.purple[0]
    let g:terminal_color_14 = s:terminal.cyan[0]
    let g:terminal_color_15 = s:terminal.white[0]
  endif
  " }}}
endif
" }}}
" Plugins: {{{
" nvim-treesitter/nvim-treesitter {{{
call sonokai_mini#highlight('TSStrong', s:palette.none, s:palette.none, 'bold')
call sonokai_mini#highlight('TSEmphasis', s:palette.none, s:palette.none, 'italic')
call sonokai_mini#highlight('TSUnderline', s:palette.none, s:palette.none, 'underline')
call sonokai_mini#highlight('TSNote', s:palette.bg0, s:palette.green, 'bold')
call sonokai_mini#highlight('TSWarning', s:palette.bg0, s:palette.yellow, 'bold')
call sonokai_mini#highlight('TSDanger', s:palette.bg0, s:palette.red, 'bold')
highlight! link TSAnnotation BlueItalic
highlight! link TSAttribute BlueItalic
highlight! link TSBoolean Purple
highlight! link TSCharacter Yellow
highlight! link TSCharacterSpecial SpecialChar
highlight! link TSComment Comment
highlight! link TSConditional Red
highlight! link TSConstBuiltin PurpleItalic
highlight! link TSConstMacro PurpleItalic
highlight! link TSConstant Fg
highlight! link TSConstructor Green
highlight! link TSDebug Debug
highlight! link TSDefine Define
highlight! link TSEnvironment Macro
highlight! link TSEnvironmentName Type
highlight! link TSError Error
highlight! link TSException Red
highlight! link TSField Orange
highlight! link TSFloat Purple
highlight! link TSFuncBuiltin Green
highlight! link TSFuncMacro Green
highlight! link TSFunction Green
highlight! link TSFunctionCall Green
highlight! link TSInclude Red
highlight! link TSKeyword Red
highlight! link TSKeywordFunction Red
highlight! link TSKeywordOperator Red
highlight! link TSKeywordReturn Red
highlight! link TSLabel Red
highlight! link TSLiteral String
highlight! link TSMath Yellow
highlight! link TSMethod Green
highlight! link TSMethodCall Green
highlight! link TSNamespace BlueItalic
highlight! link TSNone Fg
highlight! link TSNumber Purple
highlight! link TSOperator Red
highlight! link TSParameter Fg
highlight! link TSParameterReference Fg
highlight! link TSPreProc PreProc
highlight! link TSProperty Orange
highlight! link TSPunctBracket Grey
highlight! link TSPunctDelimiter Grey
highlight! link TSPunctSpecial Yellow
highlight! link TSRepeat Red
highlight! link TSStorageClass Red
highlight! link TSStorageClassLifetime Red
highlight! link TSStrike Grey
highlight! link TSString Yellow
highlight! link TSStringEscape Green
highlight! link TSStringRegex Green
highlight! link TSStringSpecial SpecialChar
highlight! link TSSymbol Fg
highlight! link TSTag BlueItalic
highlight! link TSTagAttribute Green
highlight! link TSTagDelimiter Red
highlight! link TSText Green
highlight! link TSTextReference Constant
highlight! link TSTitle Title
highlight! link TSTodo Todo
highlight! link TSType BlueItalic
highlight! link TSTypeBuiltin BlueItalic
highlight! link TSTypeDefinition BlueItalic
highlight! link TSTypeQualifier Red
highlight! link TSURI markdownUrl
highlight! link TSVariable Fg
highlight! link TSVariableBuiltin PurpleItalic
if has('nvim-0.8.0')
  highlight! link @annotation TSAnnotation
  highlight! link @attribute TSAttribute
  highlight! link @boolean TSBoolean
  highlight! link @character TSCharacter
  highlight! link @character.special TSCharacterSpecial
  highlight! link @comment TSComment
  highlight! link @conceal Grey
  highlight! link @conditional TSConditional
  highlight! link @constant TSConstant
  highlight! link @constant.builtin TSConstBuiltin
  highlight! link @constant.macro TSConstMacro
  highlight! link @constructor TSConstructor
  highlight! link @debug TSDebug
  highlight! link @define TSDefine
  highlight! link @error TSError
  highlight! link @exception TSException
  highlight! link @field TSField
  highlight! link @float TSFloat
  highlight! link @function TSFunction
  highlight! link @function.builtin TSFuncBuiltin
  highlight! link @function.call TSFunctionCall
  highlight! link @function.macro TSFuncMacro
  highlight! link @include TSInclude
  highlight! link @keyword TSKeyword
  highlight! link @keyword.function TSKeywordFunction
  highlight! link @keyword.operator TSKeywordOperator
  highlight! link @keyword.return TSKeywordReturn
  highlight! link @label TSLabel
  highlight! link @math TSMath
  highlight! link @method TSMethod
  highlight! link @method.call TSMethodCall
  highlight! link @namespace TSNamespace
  highlight! link @none TSNone
  highlight! link @number TSNumber
  highlight! link @operator TSOperator
  highlight! link @parameter TSParameter
  highlight! link @parameter.reference TSParameterReference
  highlight! link @preproc TSPreProc
  highlight! link @property TSProperty
  highlight! link @punctuation.bracket TSPunctBracket
  highlight! link @punctuation.delimiter TSPunctDelimiter
  highlight! link @punctuation.special TSPunctSpecial
  highlight! link @repeat TSRepeat
  highlight! link @storageclass TSStorageClass
  highlight! link @storageclass.lifetime TSStorageClassLifetime
  highlight! link @strike TSStrike
  highlight! link @string TSString
  highlight! link @string.escape TSStringEscape
  highlight! link @string.regex TSStringRegex
  highlight! link @string.special TSStringSpecial
  highlight! link @symbol TSSymbol
  highlight! link @tag TSTag
  highlight! link @tag.attribute TSTagAttribute
  highlight! link @tag.delimiter TSTagDelimiter
  highlight! link @text TSText
  highlight! link @text.danger TSDanger
  highlight! link @text.diff.add diffAdded
  highlight! link @text.diff.delete diffRemoved
  highlight! link @text.emphasis TSEmphasis
  highlight! link @text.environment TSEnvironment
  highlight! link @text.environment.name TSEnvironmentName
  highlight! link @text.literal TSLiteral
  highlight! link @text.math TSMath
  highlight! link @text.note TSNote
  highlight! link @text.reference TSTextReference
  highlight! link @text.strike TSStrike
  highlight! link @text.strong TSStrong
  highlight! link @text.title TSTitle
  highlight! link @text.todo TSTodo
  highlight! link @text.todo.checked Green
  highlight! link @text.todo.unchecked Ignore
  highlight! link @text.underline TSUnderline
  highlight! link @text.uri TSURI
  highlight! link @text.warning TSWarning
  highlight! link @todo TSTodo
  highlight! link @type TSType
  highlight! link @type.builtin TSTypeBuiltin
  highlight! link @type.definition TSTypeDefinition
  highlight! link @type.qualifier TSTypeQualifier
  highlight! link @uri TSURI
  highlight! link @variable TSVariable
  highlight! link @variable.builtin TSVariableBuiltin
endif
if has('nvim-0.9.0')
  highlight! link @lsp.type.class TSType
  highlight! link @lsp.type.comment TSComment
  highlight! link @lsp.type.decorator TSFunction
  highlight! link @lsp.type.enum TSType
  highlight! link @lsp.type.enumMember TSProperty
  highlight! link @lsp.type.events TSLabel
  highlight! link @lsp.type.function TSFunction
  highlight! link @lsp.type.interface TSType
  highlight! link @lsp.type.keyword TSKeyword
  highlight! link @lsp.type.macro TSConstMacro
  highlight! link @lsp.type.method TSMethod
  highlight! link @lsp.type.modifier TSTypeQualifier
  highlight! link @lsp.type.namespace TSNamespace
  highlight! link @lsp.type.number TSNumber
  highlight! link @lsp.type.operator TSOperator
  highlight! link @lsp.type.parameter TSParameter
  highlight! link @lsp.type.property TSProperty
  highlight! link @lsp.type.regexp TSStringRegex
  highlight! link @lsp.type.string TSString
  highlight! link @lsp.type.struct TSType
  highlight! link @lsp.type.type TSType
  highlight! link @lsp.type.typeParameter TSTypeDefinition
  highlight! link @lsp.type.variable TSVariable
  highlight! link DiagnosticUnnecessary WarningText
endif
highlight! link TSModuleInfoGood Green
highlight! link TSModuleInfoBad Red
" }}}
" junegunn/fzf.vim {{{
let g:fzf_colors = {
      \ 'fg': ['fg', 'Normal'],
      \ 'bg': ['bg', 'Normal'],
      \ 'hl': ['fg', 'Green'],
      \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+': ['fg', 'Green'],
      \ 'info': ['fg', 'Yellow'],
      \ 'border':  ['fg', 'Grey'],
      \ 'prompt': ['fg', 'Red'],
      \ 'pointer': ['fg', 'Blue'],
      \ 'marker': ['fg', 'Blue'],
      \ 'spinner': ['fg', 'Yellow'],
      \ 'header': ['fg', 'Blue']
      \ }
" }}}
" Yggdroot/indentLine {{{
let g:indentLine_color_gui = s:palette.grey_dim[0]
let g:indentLine_color_term = s:palette.grey_dim[1]
" }}}
" unblevable/quick-scope {{{
call sonokai_mini#highlight('QuickScopePrimary', s:palette.green, s:palette.none, 'underline')
call sonokai_mini#highlight('QuickScopeSecondary', s:palette.blue, s:palette.none, 'underline')
" }}}
if has('nvim')
" hrsh7th/nvim-cmp {{{
call sonokai_mini#highlight('CmpItemAbbrMatch', s:palette.green, s:palette.none, 'bold')
call sonokai_mini#highlight('CmpItemAbbrMatchFuzzy', s:palette.green, s:palette.none, 'bold')
highlight! link CmpItemAbbr Fg
highlight! link CmpItemAbbrDeprecated Grey
highlight! link CmpItemMenu Fg
highlight! link CmpItemKind Blue
for kind in g:sonokai_mini_lsp_kind_color
  execute "highlight! link CmpItemKind" . kind[0] . " " . kind[1]
endfor
" }}}
" nvim-telescope/telescope.nvim {{{
call sonokai_mini#highlight('TelescopeMatching', s:palette.green, s:palette.none, 'bold')
highlight! link TelescopeBorder Grey
highlight! link TelescopePromptPrefix Blue
highlight! link TelescopeSelection DiffAdd
" }}}
endif
" Extended File Types: {{{
" Generate the `after/syntax` directory based on the comment tags in this file.
" For example, the content between `syn_begin: sh/zsh` and `syn_end` will be placed in `after/syntax/sh/sonokai_mini.vim` and `after/syntax/zsh/sonokai_mini.vim`.
if sonokai_mini#syn_exists(s:path) " If the syntax files exist.
  if s:configuration.better_performance
    if !sonokai_mini#syn_newest(s:path, s:last_modified) " Regenerate if it's not up to date.
      call sonokai_mini#syn_clean(s:path, 0)
      call sonokai_mini#syn_gen(s:path, s:last_modified, 'update')
    endif
    finish
  else
    call sonokai_mini#syn_clean(s:path, 1)
  endif
else
  if s:configuration.better_performance
    call sonokai_mini#syn_gen(s:path, s:last_modified, 'generate')
    finish
  endif
endif
" syn_begin: netrw {{{
" https://www.vim.org/scripts/script.php?script_id=1075
highlight! link netrwDir Green
highlight! link netrwClassify Green
highlight! link netrwLink Grey
highlight! link netrwSymLink Fg
highlight! link netrwExe Red
highlight! link netrwComment Grey
highlight! link netrwList Yellow
highlight! link netrwHelpCmd Blue
highlight! link netrwCmdSep Grey
highlight! link netrwVersion Purple
" syn_end }}}
" syn_begin: c/cpp/objc/objcpp {{{
" vim-cpp-enhanced-highlight: https://github.com/octol/vim-cpp-enhanced-highlight{{{
highlight! link cLabel Red
highlight! link cppSTLnamespace BlueItalic
highlight! link cppSTLtype BlueItalic
highlight! link cppAccess Red
highlight! link cppStructure Red
highlight! link cppSTLios BlueItalic
highlight! link cppSTLiterator BlueItalic
highlight! link cppSTLexception Red
" }}}
" vim-cpp-modern: https://github.com/bfrg/vim-cpp-modern{{{
highlight! link cppSTLVariable BlueItalic
" }}}
" chromatica: https://github.com/arakashic/chromatica.nvim{{{
highlight! link Member TSVariable
highlight! link Variable TSVariable
highlight! link Namespace TSNamespace
highlight! link EnumConstant TSNumber
highlight! link chromaticaException TSException
highlight! link chromaticaCast TSLabel
highlight! link OperatorOverload TSOperator
highlight! link AccessQual TSOperator
highlight! link Linkage TSOperator
highlight! link AutoType TSType
" }}}
" vim-lsp-cxx-highlight https://github.com/jackguo380/vim-lsp-cxx-highlight{{{
highlight! link LspCxxHlSkippedRegion Grey
highlight! link LspCxxHlSkippedRegionBeginEnd TSKeyword
highlight! link LspCxxHlGroupEnumConstant OrangeItalic
highlight! link LspCxxHlGroupNamespace TSNamespace
highlight! link LspCxxHlGroupMemberVariable TSVariable
" }}}
" syn_end }}}
" syn_begin: cs {{{
" builtin: https://github.com/nickspoons/vim-cs{{{
highlight! link csUnspecifiedStatement Red
highlight! link csStorage Red
highlight! link csClass Red
highlight! link csNewType BlueItalic
highlight! link csContextualStatement Red
highlight! link csInterpolationDelimiter Purple
highlight! link csInterpolation Purple
highlight! link csEndColon Fg
" }}}
" syn_end }}}
" syn_begin: python {{{
" builtin: {{{
highlight! link pythonBuiltin BlueItalic
highlight! link pythonExceptions Red
highlight! link pythonDecoratorName OrangeItalic
" }}}
" python-syntax: https://github.com/vim-python/python-syntax{{{
highlight! link pythonExClass BlueItalic
highlight! link pythonBuiltinType BlueItalic
highlight! link pythonBuiltinObj OrangeItalic
highlight! link pythonDottedName OrangeItalic
highlight! link pythonBuiltinFunc Green
highlight! link pythonFunction Green
highlight! link pythonDecorator OrangeItalic
highlight! link pythonInclude Include
highlight! link pythonImport PreProc
highlight! link pythonOperator Red
highlight! link pythonConditional Red
highlight! link pythonRepeat Red
highlight! link pythonException Red
highlight! link pythonNone OrangeItalic
highlight! link pythonCoding Grey
highlight! link pythonDot Grey
" }}}
" semshi: https://github.com/numirias/semshi{{{
call sonokai_mini#highlight('semshiUnresolved', s:palette.orange, s:palette.none, 'undercurl')
highlight! link semshiImported TSInclude
highlight! link semshiParameter TSParameter
highlight! link semshiParameterUnused Grey
highlight! link semshiSelf TSVariableBuiltin
highlight! link semshiGlobal TSType
highlight! link semshiBuiltin TSTypeBuiltin
highlight! link semshiAttribute TSAttribute
highlight! link semshiLocal TSKeyword
highlight! link semshiFree TSKeyword
highlight! link semshiSelected CurrentWord
highlight! link semshiErrorSign RedSign
highlight! link semshiErrorChar RedSign
" }}}
" syn_end }}}
" syn_begin: lua {{{
" builtin: {{{
highlight! link luaFunc Green
highlight! link luaFunction Red
highlight! link luaTable Fg
highlight! link luaIn Red
" }}}
" vim-lua: https://github.com/tbastos/vim-lua {{{
highlight! link luaFuncCall Green
highlight! link luaLocal Red
highlight! link luaSpecialValue Green
highlight! link luaBraces Fg
highlight! link luaBuiltIn BlueItalic
highlight! link luaNoise Grey
highlight! link luaLabel Purple
highlight! link luaFuncTable BlueItalic
highlight! link luaFuncArgName Fg
highlight! link luaEllipsis Red
highlight! link luaDocTag Green
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link luaTSConstructor luaBraces
if has('nvim-0.8.0')
  highlight! link @constructor.lua luaTSConstructor
endif
" }}}
" syn_end }}}
" syn_begin: go {{{
" builtin: https://github.com/google/vim-ft-go{{{
highlight! link goDirective Red
highlight! link goConstants OrangeItalic
highlight! link goDeclType Red
" }}}
" polyglot: {{{
highlight! link goPackage Red
highlight! link goImport Red
highlight! link goBuiltins Green
highlight! link goPredefinedIdentifiers OrangeItalic
highlight! link goVar Red
" }}}
" syn_end }}}
" syn_begin: rust {{{
" builtin: https://github.com/rust-lang/rust.vim{{{
highlight! link rustStructure Red
highlight! link rustIdentifier OrangeItalic
highlight! link rustModPath BlueItalic
highlight! link rustModPathSep Grey
highlight! link rustSelf OrangeItalic
highlight! link rustSuper OrangeItalic
highlight! link rustDeriveTrait Purple
highlight! link rustEnumVariant Purple
highlight! link rustMacroVariable OrangeItalic
highlight! link rustAssert Green
highlight! link rustPanic Green
highlight! link rustPubScopeCrate BlueItalic
highlight! link rustAttribute Purple
" }}}
" coc-rust-analyzer: https://github.com/fannheyward/coc-rust-analyzer {{{
highlight! link CocRustChainingHint Grey
highlight! link CocRustTypeHint Grey
" }}}
" syn_end }}}
" syn_begin: sh/zsh {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_SH{{{
highlight! link shRange Fg
highlight! link shOption Purple
highlight! link shQuote Yellow
highlight! link shVariable BlueItalic
highlight! link shDerefSimple BlueItalic
highlight! link shDerefVar BlueItalic
highlight! link shDerefSpecial BlueItalic
highlight! link shDerefOff BlueItalic
highlight! link shVarAssign Red
highlight! link shFunctionOne Green
highlight! link shFunctionKey Red
" }}}
" syn_end }}}
" syn_begin: zsh {{{
" builtin: https://github.com/chrisbra/vim-zsh{{{
highlight! link zshOption BlueItalic
highlight! link zshSubst Orange
highlight! link zshFunction Green
" }}}
" syn_end }}}
" syn_begin: vim {{{
call sonokai_mini#highlight('vimCommentTitle', s:palette.grey, s:palette.none, 'bold')
highlight! link vimLet Red
highlight! link vimFunction Green
highlight! link vimIsCommand Fg
highlight! link vimUserFunc Green
highlight! link vimFuncName Green
highlight! link vimMap BlueItalic
highlight! link vimNotation Purple
highlight! link vimMapLhs Green
highlight! link vimMapRhs Green
highlight! link vimSetEqual BlueItalic
highlight! link vimSetSep Fg
highlight! link vimOption BlueItalic
highlight! link vimUserAttrbKey BlueItalic
highlight! link vimUserAttrb Green
highlight! link vimAutoCmdSfxList Orange
highlight! link vimSynType Orange
highlight! link vimHiBang Orange
highlight! link vimSet BlueItalic
highlight! link vimSetSep Grey
" syn_end }}}
" syn_begin: make {{{
highlight! link makeIdent Purple
highlight! link makeSpecTarget BlueItalic
highlight! link makeTarget Orange
highlight! link makeCommands Red
" syn_end }}}
" syn_begin: cmake {{{
highlight! link cmakeCommand Red
highlight! link cmakeKWconfigure_package_config_file BlueItalic
highlight! link cmakeKWwrite_basic_package_version_file BlueItalic
highlight! link cmakeKWExternalProject Green
highlight! link cmakeKWadd_compile_definitions Green
highlight! link cmakeKWadd_compile_options Green
highlight! link cmakeKWadd_custom_command Green
highlight! link cmakeKWadd_custom_target Green
highlight! link cmakeKWadd_definitions Green
highlight! link cmakeKWadd_dependencies Green
highlight! link cmakeKWadd_executable Green
highlight! link cmakeKWadd_library Green
highlight! link cmakeKWadd_link_options Green
highlight! link cmakeKWadd_subdirectory Green
highlight! link cmakeKWadd_test Green
highlight! link cmakeKWbuild_command Green
highlight! link cmakeKWcmake_host_system_information Green
highlight! link cmakeKWcmake_minimum_required Green
highlight! link cmakeKWcmake_parse_arguments Green
highlight! link cmakeKWcmake_policy Green
highlight! link cmakeKWconfigure_file Green
highlight! link cmakeKWcreate_test_sourcelist Green
highlight! link cmakeKWctest_build Green
highlight! link cmakeKWctest_configure Green
highlight! link cmakeKWctest_coverage Green
highlight! link cmakeKWctest_memcheck Green
highlight! link cmakeKWctest_run_script Green
highlight! link cmakeKWctest_start Green
highlight! link cmakeKWctest_submit Green
highlight! link cmakeKWctest_test Green
highlight! link cmakeKWctest_update Green
highlight! link cmakeKWctest_upload Green
highlight! link cmakeKWdefine_property Green
highlight! link cmakeKWdoxygen_add_docs Green
highlight! link cmakeKWenable_language Green
highlight! link cmakeKWenable_testing Green
highlight! link cmakeKWexec_program Green
highlight! link cmakeKWexecute_process Green
highlight! link cmakeKWexport Green
highlight! link cmakeKWexport_library_dependencies Green
highlight! link cmakeKWfile Green
highlight! link cmakeKWfind_file Green
highlight! link cmakeKWfind_library Green
highlight! link cmakeKWfind_package Green
highlight! link cmakeKWfind_path Green
highlight! link cmakeKWfind_program Green
highlight! link cmakeKWfltk_wrap_ui Green
highlight! link cmakeKWforeach Green
highlight! link cmakeKWfunction Green
highlight! link cmakeKWget_cmake_property Green
highlight! link cmakeKWget_directory_property Green
highlight! link cmakeKWget_filename_component Green
highlight! link cmakeKWget_property Green
highlight! link cmakeKWget_source_file_property Green
highlight! link cmakeKWget_target_property Green
highlight! link cmakeKWget_test_property Green
highlight! link cmakeKWif Green
highlight! link cmakeKWinclude Green
highlight! link cmakeKWinclude_directories Green
highlight! link cmakeKWinclude_external_msproject Green
highlight! link cmakeKWinclude_guard Green
highlight! link cmakeKWinstall Green
highlight! link cmakeKWinstall_files Green
highlight! link cmakeKWinstall_programs Green
highlight! link cmakeKWinstall_targets Green
highlight! link cmakeKWlink_directories Green
highlight! link cmakeKWlist Green
highlight! link cmakeKWload_cache Green
highlight! link cmakeKWload_command Green
highlight! link cmakeKWmacro Green
highlight! link cmakeKWmark_as_advanced Green
highlight! link cmakeKWmath Green
highlight! link cmakeKWmessage Green
highlight! link cmakeKWoption Green
highlight! link cmakeKWproject Green
highlight! link cmakeKWqt_wrap_cpp Green
highlight! link cmakeKWqt_wrap_ui Green
highlight! link cmakeKWremove Green
highlight! link cmakeKWseparate_arguments Green
highlight! link cmakeKWset Green
highlight! link cmakeKWset_directory_properties Green
highlight! link cmakeKWset_property Green
highlight! link cmakeKWset_source_files_properties Green
highlight! link cmakeKWset_target_properties Green
highlight! link cmakeKWset_tests_properties Green
highlight! link cmakeKWsource_group Green
highlight! link cmakeKWstring Green
highlight! link cmakeKWsubdirs Green
highlight! link cmakeKWtarget_compile_definitions Green
highlight! link cmakeKWtarget_compile_features Green
highlight! link cmakeKWtarget_compile_options Green
highlight! link cmakeKWtarget_include_directories Green
highlight! link cmakeKWtarget_link_directories Green
highlight! link cmakeKWtarget_link_libraries Green
highlight! link cmakeKWtarget_link_options Green
highlight! link cmakeKWtarget_precompile_headers Green
highlight! link cmakeKWtarget_sources Green
highlight! link cmakeKWtry_compile Green
highlight! link cmakeKWtry_run Green
highlight! link cmakeKWunset Green
highlight! link cmakeKWuse_mangled_mesa Green
highlight! link cmakeKWvariable_requires Green
highlight! link cmakeKWvariable_watch Green
highlight! link cmakeKWwrite_file Green
" syn_end }}}
" syn_begin: json {{{
highlight! link jsonKeyword Red
highlight! link jsonString Green
highlight! link jsonBoolean Blue
highlight! link jsonNoise Grey
highlight! link jsonQuote Grey
highlight! link jsonBraces Fg
" syn_end }}}
" syn_begin: yaml {{{
highlight! link yamlKey Red
highlight! link yamlConstant BlueItalic
highlight! link yamlString Green
" syn_end }}}
" syn_begin: toml {{{
call sonokai_mini#highlight('tomlTable', s:palette.purple, s:palette.none, 'bold')
highlight! link tomlKey Red
highlight! link tomlBoolean Blue
highlight! link tomlString Green
highlight! link tomlTableArray tomlTable
" syn_end }}}
" syn_begin: gitcommit {{{
" builtin {{{
highlight! link gitcommitSummary Red
highlight! link gitcommitUntracked Grey
highlight! link gitcommitDiscarded Grey
highlight! link gitcommitSelected Grey
highlight! link gitcommitUnmerged Grey
highlight! link gitcommitOnBranch Grey
highlight! link gitcommitArrow Grey
highlight! link gitcommitFile Green
" }}}
" nvim-treesitter/nvim-treesitter {{{
if has('nvim-0.8.0')
  highlight! link @text.gitcommit TSNone
endif
" }}}
" syn_end }}}
" syn_begin: help {{{
call sonokai_mini#highlight('helpNote', s:palette.purple, s:palette.none, 'bold')
call sonokai_mini#highlight('helpHeadline', s:palette.red, s:palette.none, 'bold')
call sonokai_mini#highlight('helpHeader', s:palette.orange, s:palette.none, 'bold')
call sonokai_mini#highlight('helpURL', s:palette.green, s:palette.none, 'underline')
call sonokai_mini#highlight('helpHyperTextEntry', s:palette.blue, s:palette.none, 'bold')
highlight! link helpHyperTextJump Blue
highlight! link helpCommand Yellow
highlight! link helpExample Green
highlight! link helpSpecial Purple
highlight! link helpSectionDelim Grey
" syn_end }}}
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
