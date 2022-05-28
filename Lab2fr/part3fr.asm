# UNTITLED PROGRAM

	.data		# Data declaration section
	
Z:	.word	2
i:	.word	0

	.text

main:			# Start of code section
	
	lw  x1, Z #  Z
	lw sp, i # i = 0
	
for:	slti s2, sp, 21 # s11 = 1 when i < 21 --> i <= 20
	beq s2, zero, NvmF #if s11 = 0 --> NvmF
	addi x1, x1, 1 # Z++
	addi sp, sp, 2 # i = i + 2
	j for
	
NvmF:

	doWhile:
		addi x1, x1, 1 # Z++
		slti s2, x1, 100     
		beq s2, zero, nvmDo #if s11 = 0 --> nvmDo
		j doWhile

nvmDo:
	
	last:	slt s2, zero, sp
		beq s2, zero, nvmWhile #if s11=0 --> nvmWhile
		addi x1, x1, -1  #ra = ra -1 
		addi sp, sp, -1  #sp = sp -1 
		j last
	
nvmWhile:
	sw x1, Z, t6 # Z result in s2 
	
# END OF PROGRAM