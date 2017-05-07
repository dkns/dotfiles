#!/usr/bin/env python3
# Display the colors available in a terminal.

for color in range(0, 256):
    for i in range(0, 1):
        print("\033[38;5;%sm%03s\033[m" % (str(color), str(color)), end=' ')
    if color % 10 == 0:
        print()
