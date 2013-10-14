set expandtab

" build tags of our source with F-12
nnoremap <F12> :!ctags -R --python-kinds=+i --exclude="webapp/static_design/*" --exclude="webapp/static/webapp/js/*" --exclude="chromex/static/chromex/js_libs/*" .<cr>
inoremap <F12> <Esc>:!ctags -R --python-kinds=+i --exclude="webapp/static_design/*" --exclude="webapp/static/webapp/js/*" --exclude="chromex/static/chromex/js_libs/*" .<cr>

