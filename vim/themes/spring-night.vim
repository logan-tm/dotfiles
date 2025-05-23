" spring-night : Calm-colored dark color scheme
"
" Author: rhysd <lin90162@yahoo.co.jp>
" License: MIT
"   Copyright (c) 2016 rhysd

set background=dark
if v:version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists('g:syntax_on')
        syntax reset
    endif
endif
let g:colors_name = 'spring-night'

let s:gui_running = has('gui_running')

let g:spring_night_kill_italic = get(g:, 'spring_night_kill_italic', 0)
let g:spring_night_high_contrast = get(g:, 'spring_night_high_contrast',
            \ !s:gui_running && has('termguicolors') && &termguicolors ?
            \   ['cui'] : [])

let s:high_contrast =
    \ (s:gui_running && index(g:spring_night_high_contrast, 'gui') >= 0) ||
    \ (!s:gui_running && index(g:spring_night_high_contrast, 'cui') >= 0)

" Define reusable color palette.
let s:bg         = [s:high_contrast ? '#132132' : '#334152', 233]
let s:bgemphasis = ['#3a4b5c', 235]
let s:bgstrong   = ['#536273', 238]
let s:fg         = ['#fffeeb', s:high_contrast ? 231 : 230]
let s:hiddenfg   = ['#607080', 60]
let s:weakfg     = ['#8090a0', 103]
let s:weakerfg   = ['#788898', 102]
let s:palepink   = ['#ebeadb', 224]
let s:yellow     = ['#fffaaa', 229]
let s:white      = ['#ffffff', 231]
let s:purple     = ['#e7d5ff', 189]
let s:gray       = ['#545f6e', 59]
let s:light      = ['#646f7c', 60]
let s:sakura     = ['#a9667a', 132]
let s:orange     = ['#f0aa8a', 216]
let s:green      = ['#a9dd9d', 150]
let s:darkgreen  = ['#5f8770', 65]
let s:skyblue    = ['#a8d2eb', 153]
let s:gold       = ['#fedf81', 222]
let s:darkgold   = ['#685800', 58]
let s:red        = ['#fd8489', 210]
let s:mildred    = ['#ab6560', 167]
let s:mikan      = ['#fb8965', 209]
let s:NONE       = ['NONE', 'NONE']

let s:NUMBER_TYPE = type(0)

function! s:hi(name, fg, bg, attr) abort
    let has_fg = type(a:fg) != s:NUMBER_TYPE
    let has_bg = type(a:bg) != s:NUMBER_TYPE

    let guifg   = has_fg ? ('guifg=' . a:fg[0]) : ''
    let guibg   = has_bg ? ('guibg=' . a:bg[0]) : ''
    let ctermfg = has_fg ? ('ctermfg=' . a:fg[1]) : ''
    let ctermbg = ''

    let is_italic = a:attr ==# 'italic'
    if type(a:attr) != s:NUMBER_TYPE && !(g:spring_night_kill_italic && is_italic)
        let attr =  'gui=' . a:attr
        if !is_italic
            let attr .= ' cterm=' . a:attr
        endif
    else
        let attr = ''
    endif

    " XXX: term=NONE is a workaround for unintentional default values
    exe 'hi' a:name 'term=NONE' guifg guibg ctermfg ctermbg attr
endfunction

"         Name,           Foreground,   Background,   Attribute
call s:hi('Boolean',      s:red,        0,            0)
call s:hi('Character',    s:green,      0,            0)
call s:hi('ColorColumn',  0,            s:bgstrong,   0)
call s:hi('Comment',      s:weakfg,     0,            0)
call s:hi('Conceal',      s:mikan,      s:bg,         0)
call s:hi('Conditional',  s:skyblue,    0,            0)
call s:hi('Constant',     s:red,        0,            0)
call s:hi('Cursor',       s:bg,         s:fg,         0)
call s:hi('CursorColumn', 0,            s:bgemphasis, 0)
call s:hi('CursorLineNr', s:purple,     s:bgstrong,   0)
call s:hi('Cursorline',   0,            s:bgemphasis, 0)
call s:hi('Define',       s:orange,     0,            0)
call s:hi('Directory',    s:green,      0,            0)
call s:hi('EndOfBuffer',  s:bgstrong,   0,            0)
call s:hi('Error',        s:red,        s:bgemphasis, 'bold')
call s:hi('ErrorMsg',     s:red,        s:bg,         'bold')
call s:hi('Float',        s:red,        0,            0)
call s:hi('FoldColumn',   0,            s:bgemphasis, 0)
call s:hi('Folded',       s:purple,     s:light,      0)
call s:hi('Function',     s:orange,     0,            0)
call s:hi('Identifier',   s:gold,       0,            'italic')
call s:hi('Keyword',      s:yellow,     0,            'bold')
call s:hi('Label',        s:skyblue,    0,            0)
call s:hi('LineNr',       s:weakerfg,   s:bgemphasis, 0)
call s:hi('MatchParen',   s:bg,         s:sakura,     'underline')
call s:hi('ModeMsg',      s:gold,       0,            0)
call s:hi('MoreMsg',      s:green,      0,            0)
call s:hi('NonText',      s:light,      0,            0)
call s:hi('Normal',       s:fg,         s:bg,         0)
call s:hi('Number',       s:red,        0,            0)
call s:hi('Operater',     s:orange,     0,            0)
call s:hi('Pmenu',        s:purple,     s:bgemphasis, 0)
call s:hi('PmenuSel',     s:gold,       s:bgstrong,   0)
call s:hi('PreProc',      s:orange,     0,            0)
call s:hi('Question',     s:skyblue,    0,            0)
call s:hi('Search',       s:NONE,       s:sakura,     'underline')
call s:hi('SignColumn',   0,            s:bgemphasis, 0)
call s:hi('Special',      s:yellow,     0,            'bold')
call s:hi('SpecialKey',   s:hiddenfg,   0,            0)
call s:hi('SpellBad',     0,            s:mildred,    0)
call s:hi('SpellCap',     0,            s:light,      0)
call s:hi('SpellLocal',   0,            s:bgemphasis, 0)
call s:hi('SpellRare',    0,            s:sakura,     0)
call s:hi('Statement',    s:skyblue,    0,            0)
call s:hi('StatusLine',   s:fg,         s:bgstrong,   'bold')
call s:hi('StatusLineNC', s:weakfg,     s:bgemphasis, 'NONE')
call s:hi('StorageClass', s:gold,       0,            'italic')
call s:hi('String',       s:green,      0,            0)
call s:hi('TabLine',      s:weakfg,     s:bgstrong,   0)
call s:hi('TabLineFill',  s:bgemphasis, 0,            0)
call s:hi('TabLineSel',   s:gold,       s:bg,         'bold')
call s:hi('Tag',          s:orange,     0,            0)
call s:hi('Title',        s:gold,       0,            'bold')
call s:hi('Todo',         s:bg,         s:red,        'bold')
call s:hi('Type',         s:gold,       0,            0)
call s:hi('Underlined',   s:skyblue,    0,            'underline')
call s:hi('VertSplit',    s:bgemphasis, s:bg,         0)
call s:hi('Visual',       0,            s:sakura,     0)
call s:hi('WarningMsg',   s:mikan,      s:bgemphasis, 0)
call s:hi('WildMenu',     0,            s:gold,       0)
" TODO: call s:hi('QuickFixLine',     0,            0,       0)

" Filetype specific
"
" Markdown is highlighted with HTML highlights in gVim but link text doesn't
" have a color. So define it here.
call s:hi('cmakeArguments',           s:yellow,  0,            0)
call s:hi('cmakeOperators',           s:red,     0,            0)
call s:hi('DiffAdd',                  0,         s:darkgreen,  'bold')
call s:hi('DiffChange',               0,         s:darkgold,   'bold')
call s:hi('DiffDelete',               0,         s:mildred,    'bold')
call s:hi('DiffText',                 0,         s:bg,         0)
call s:hi('GitGutterAdd',             s:green,   s:bgemphasis, 0)
call s:hi('GitGutterChange',          s:yellow,  s:bgemphasis, 0)
call s:hi('GitGutterChangeDelete',    s:gold,    s:bgemphasis, 0)
call s:hi('GitGutterDelete',          s:red,     s:bgemphasis, 0)
call s:hi('diffAdded',                s:green,   0,            0)
call s:hi('diffFile',                 s:yellow,  0,            0)
call s:hi('diffIndexLine',            s:gold,    0,            0)
call s:hi('diffNewFile',              s:yellow,  0,            0)
call s:hi('diffRemoved',              s:red,     0,            0)
call s:hi('EasyMotionTarget',         s:red,     0,            'bold')
call s:hi('EasyMotionShade',          s:weakfg,  s:bg,         0)
call s:hi('gitCommitOverflow',        0,         s:red,        0)
call s:hi('gitCommitSummary',         s:yellow,  0,            0)
call s:hi('gitCommitSelectedFile',    s:skyblue, 0,            0)
call s:hi('gitconfigSection',         s:skyblue, 0,            'bold')
call s:hi('goBuiltins',               s:red,     0,            0)
call s:hi('helpExample',              s:skyblue, 0,            0)
call s:hi('htmlBold',                 0,         s:bgemphasis, 0)
call s:hi('htmlLinkText',             s:skyblue, 0,            0)
call s:hi('htmlTagName',              s:orange,  0,            0)
call s:hi('javaScriptBraces',         s:fg,      0,            0)
call s:hi('makeCommands',             s:yellow,  0,            0)
call s:hi('markdownCode',             s:yellow,  0,            0)
call s:hi('markdownUrl',              s:weakfg,  0,            0)
call s:hi('ocamlConstructor',         s:gold,    0,            0)
call s:hi('ocamlKeyChar',             s:skyblue, 0,            0)
call s:hi('ocamlKeyword',             s:gold   , 0,            0)
call s:hi('ocamlFunDef',              s:skyblue, 0,            0)
call s:hi('pythonBuiltin',            s:red,     0,            0)
call s:hi('qfFileName',               s:gold,    0,            0)
call s:hi('qfLineNr',                 s:skyblue, 0,            0)
call s:hi('rubyFunction',             s:yellow,  0,            0)
call s:hi('rubyIdentifier',           s:yellow,  0,            0)
call s:hi('rustEnumVariant',          s:gold,    0,            0)
call s:hi('rustFuncCall',             s:yellow,  0,            0)
call s:hi('typescriptBraces',         s:fg,      0,            0)
call s:hi('vimfilerColumn__SizeLine', s:weakfg,  0,            0)
call s:hi('vimfilerClosedFile',       s:green,   0,            0)
call s:hi('vimCommand',               s:skyblue, 0,            0)
call s:hi('zshDelimiter',             s:skyblue, 0,            0)
call s:hi('zshPrecommand',            s:red,     0,            0)
call s:hi('CleverFChar',              s:bg,      s:red,        0)
if s:gui_running
    call s:hi('EasyMotionIncCursor',s:bg,     s:fg,         0)
else
    " In terminal, cursor color is simply reversed
    call s:hi('EasyMotionIncCursor',0,        0,            'reverse')
endif
