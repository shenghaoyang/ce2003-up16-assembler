#include "up16_core.asm"

nop
start:
    lli r4, #0x71
    ; replace second nop with lli r3 #0xff for task 1
    lli r3, #0xff
    lli r1, #1
    lli r2, #2
    lui r4, r4, #0xf9
    add r2, r1
    mov r5, r3
    addi r3, r1, #1
    addi r6, r4, #5
    jmp proc3

proc2:
    nop
    add r4, r1
    or r2, r4
    nop

proc3:
    sw r4, r1, #0
    sw r5, r1, #1
    nop
    lw r6, r1, #0
    add r1, r6
    lw r7, r1, #1
    add r3, r1
    add r5, r3
    nop
    lli r3, #0
    sub r6, r2
    bne r3, r0, end
    nop
    add r1, r2
    nand r2, r1
    nop
    nop
    nop

end:
    not r1, r4
    jmp start
