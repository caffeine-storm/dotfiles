set print pretty on
set print object on
set print static-members off
# set print vtbl on
set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off

set follow-fork-mode child
set detach-on-fork off

set print thread-events off

python
import sys, os.path
sys.path.insert(0, os.path.expanduser('~/dotfiles/gdb-printers'))
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

