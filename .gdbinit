set print thread-events off
python
import sys
import os.path
sys.path.insert(0, os.path.join( os.path.expanduser("~"), "dotfiles", "gdb-printers", ) )
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers( None )
end
