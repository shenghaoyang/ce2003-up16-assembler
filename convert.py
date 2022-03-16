#!/usr/bin/env python3

import sys
from bitarray import bitarray
from bitarray.util import ba2int

WORD_SIZE = 18

if __name__ == "__main__":
    asm = sys.stdin.read()
    if len(asm) % WORD_SIZE:
        raise RuntimeError("not an integer number of instruction words")

    words = len(asm) // WORD_SIZE
    asm_bits = bitarray(asm)

    print("memory_initialization_radix=16;")
    print("memory_initialization_vector=", end="")
    for i in range(words):
        last_word = i == ((words - 1))
        word = asm_bits[i * WORD_SIZE : (i + 1) * WORD_SIZE]
        int_word = ba2int(word)
        hex_word = hex(int_word)[2:]

        print(hex_word, end="," if not last_word else ";\n")
