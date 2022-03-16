#!/usr/bin/env python3

import sys
import os

WORD_SIZE = 18

if __name__ == "__main__":
    if os.isatty(sys.stdin.fileno()):
        raise RuntimeError(
            "refusing to read from TTY STDIN. Redirect input from a file instead."
        )

    asm = sys.stdin.read()
    if len(asm) % WORD_SIZE:
        raise RuntimeError("input does not have an integer number of instruction words")

    words = len(asm) // WORD_SIZE

    print("memory_initialization_radix=16;")
    print("memory_initialization_vector=", end="")
    for i in range(words):
        last_word = i == ((words - 1))
        word = asm[i * WORD_SIZE : (i + 1) * WORD_SIZE]
        int_word = int(word, 2)
        hex_word = hex(int_word)[2:]

        print(hex_word, end="," if not last_word else ";\n")
