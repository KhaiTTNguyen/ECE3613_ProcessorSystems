;
; AssemblerApplication18.asm
;
; Created: 2/24/2021 4:51:15 PM
; Author : KhaiNguyen
;


/// TIME DELAY options this if for 0.30sec
Delay_P15sec:	
	LDI R20,32
	L1_P15: LDI R21, 200
		L2_P15: LDI R22, 150
			L3_P15:NOP
				NOP
				DEC R22
				BRNE L3_P15
			DEC R21
			BRNE L2_P15
		DEC R20
		BRNE L1_P15
RET