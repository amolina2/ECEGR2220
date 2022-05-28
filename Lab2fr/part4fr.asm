.data 

	A:	.word 0, 0, 0, 0, 0
	B:	.word 1, 2, 4, 8, 16
	

	.text
	

	main:
		la t1, A # A -->t1
		la t2, B # B --> t
		
		addi s1, zero, 0  # i(s1) = 0 
		addi gp, zero, 4 # gp = 4
		
	for:	slti s3, s1, 5 # i < 5
		beq s3, zero, yesFor
		mul s4, s1, gp # i * 4
		mul s5, s1, gp # i * 4 in s5
		add s2, t2, s4 # address of B[i]
		add s5, t1, s5 # address of A[i]
		lw a0, 0(s2)	#word address
		addi a0, a0, -1  #a0 = -1
		sw a0, 0(s5) 
		addi s1, s1, 1
		j for
	

	yesFor: #when for is working 
		addi s1, s1, -1 
		addi s6, zero, -1
		
	while:	beq s1, s6, nvmWhile
		mul s4, s1, gp # i * 4
		mul s5, s1, gp
		add s4, t2, s4 # address of B[i]
		add s5, t1, s5 # address of A[i]
		lw a1, 0(s4)
		lw a2, 0(s5)
		addi a4, zero, 2
		add a3, a1, a2
		mul a3, a3, a4
		sw a3, 0(s5)
		addi s1, s1, -1
		j while
		
	nvmWhile: #end program
		li  a7,10      
	    	ecall