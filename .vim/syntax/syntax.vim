" Vim syntax support file
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last Change:  2001 Sep 04

" This file is used for ":syntax on".
" It installs the autocommands and starts highlighting for all buffers.

if !has("syntax")
  finish
endif

" If Syntax highlighting appears to be on already, turn it off first, so that
" any leftovers are cleared.
if exists("syntax_on") || exists("syntax_manual")
  so <sfile>:p:h/nosyntax.vim
endif

" Load the Syntax autocommands and set the default methods for highlighting.
runtime syntax/synload.vim

" Load the FileType autocommands if not done yet.
if exists("did_load_filetypes")
  let s:did_ft = 1
else
  filetype on
  let s:did_ft = 0
endif
