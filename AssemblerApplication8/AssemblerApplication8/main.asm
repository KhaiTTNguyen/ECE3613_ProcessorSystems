;
; AssemblerApplication8.asm
;
; Created: 2/8/2021 11:08:39 AM
; Author : KhaiNguyen
;

.set temp0=0x0166
.set temp1=0x0167
.set temp2=0x0168
.set temp3=0x0169
.set temp4=0x016A
.set temp5=0x016B
LDI r16,0x11
STS temp0, r16
STS temp1, r16
STS temp2, r16
STS temp3, r16
STS temp4, r16
STS temp5, r16

CLR r29
LDS r17, temp0
add r29, r17
LDS r17, temp1
add r29, r17
LDS r17, temp2
add r29, r17
LDS r17, temp3
add r29, r17
LDS r17, temp4
add r29, r17
LDS r17, temp5
add r29, r17
out portB, r29
nop
