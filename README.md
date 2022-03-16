Assembler for uP16
------------------

Generates Xilinx `.coe` initialization files for defining the contents
of instruction memory blocks used by the `uP16` soft microprocessor.

That microprocessor is used as an example microprocessor in lab sessions
for the CE2003 Digital Systems Design course at NTU.

# Usage

Requires [`customasm`](https://github.com/hlorenzi/customasm).

See `Makefile` and `task1.txt` for examples.

# Syntax differences

- Immediates don't default to hex.
- Jump mnemonics only accept absolute addresses, and not relative ones.
    - Use labels whenever possible.
