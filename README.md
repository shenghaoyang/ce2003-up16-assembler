Assembler for uP16
------------------

# Usage

Requires (`customasm`)[https://github.com/hlorenzi/customasm]

See `Makefile` and `task1.txt` for examples.

# Syntax differences

- Immediates don't default to hex.
- Jump mnemonics only accept absolute addresses, and not relative ones.
    - Use labels whenever possible.
