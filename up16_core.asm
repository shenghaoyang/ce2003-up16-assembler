; core uP16 instruction set.
; the uP16 soft-core processor is used in the NTU CE2003 Digital Systems Design
; course to introduce undergraduates to basic processor design.

#bits 18 ; 18 bit CPU

#bankdef program {
    #addr 0x0000
    #size 1024
    #outp 0
}

#bank program

#subruledef reg {
	{reg_num: u3} => reg_num
}

#ruledef {
	op {op_num: u4}, rd {rd: reg}, rs {rs: reg}, if {if: u8} => op_num @ rd @ rs @ if
}

#fn jump_dst_calc(target) => {
	reladdr = target - $ - 1
	assert(reladdr <=  127)
	assert(reladdr >= -128)
	reladdr`8
}

#ruledef {
	nop => asm {op 0, rd 0, rs 0, if 0}
}

; Arithmetic and logic
#ruledef {
	add  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 1}
	sub  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 2}
	and  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 3}
	 or  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 4}
	nand r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 5}
	nor  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 6}
	xor  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 7}
	not  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 8}
}

; Data transfer
#ruledef {
	mov  r{rd: reg}, r{rs: reg} => asm {op 0, rd rd, rs rs, if 0x0a}
}

; Memory access
#ruledef {
	lw r{rd: reg}, r{rs: reg}, #{off: i8} => asm {op 0x01, rd rd, rs rs, if off}
	sw r{rd: reg}, r{rs: reg}, #{off: i8} => asm {op 0x02, rd rd, rs rs, if off}
}

; Immediates
#ruledef {
	lli  r{rd: reg}, #{imm: i8} => asm {op 0x03, rd rd, rs 0, if imm}
	lui  r{rd: reg}, r{rs: reg}, #{imm: u8} => asm {op 0x04, rd rd, rs rs, if imm}
	addi r{rd: reg}, r{rs: reg}, #{imm: i8} => asm {op 0x05, rd rd, rs rs, if imm}
}

; Branching
#ruledef {
	beq  r{rd: reg}, r{rs: reg}, {dst} => asm { op 0x08, rd rd, rs rs, if jump_dst_calc(dst) }
	bne  r{rd: reg}, r{rs: reg}, {dst} => asm { op 0x09, rd rd, rs rs, if jump_dst_calc(dst) }
	bltz r{rd: reg}, r{rs: reg}, {dst} => asm { op 0x0a, rd rd, rs rs, if jump_dst_calc(dst) }
	bgtz r{rd: reg}, r{rs: reg}, {dst} => asm { op 0x0b, rd rd, rs rs, if jump_dst_calc(dst) }
    ; Short jump - +127, -128.
    ; Accepts absolute jump target, and converts that to a relative offset
    ; internally.
	jmp {dst} => asm { beq r0, r0, dst }
}
