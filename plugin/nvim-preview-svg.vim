if exists('g:loaded_preview_svg') | finish | endif " Prevent loading file twice
let s:save_cpo = &cpo
set cpo&vim

" Command to run the preview
command! PreviewSvg lua require("nvim-preview-svg").previewSvg()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_preview_svg = 1
