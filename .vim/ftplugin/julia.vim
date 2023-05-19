set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Install with julia -e 'import Pkg; Pkg.add("LanguageServer");
" Pkg.add("StaticLint"); Pkg.add("SymbolServer")'
let s:julia_cmdline = ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       debug = true;
\
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path);
\       server.runlinter = true;
\       run(server);
\   ']

let g:ycm_language_server = [
  \   { 'name': 'julia',
  \     'filetypes': [ 'julia' ],
  \     'project_root_files': [ 'Project.toml' ],
  \     'cmdline': s:julia_cmdline
  \   },
  \ ]

