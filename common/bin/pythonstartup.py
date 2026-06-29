#!/usr/bin/env python

import atexit
import os
import pathlib
import readline

xdg_state_home = os.getenv("XDG_STATE_HOME", os.path.expanduser("~/.local/state"))
histfile = pathlib.Path(xdg_state_home) / "python" / "history"
histfile.parent.mkdir(parents=True, exist_ok=True)

try:
    readline.read_history_file(histfile.name)
    # default history len is -1 (infinite), which may grow unruly
    readline.set_history_length(10000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
