.data
	

	A: .word 0
	B: .word 0
	C: .word 0
	

	.text
	

	main:
		addi t0, zero, 5 #i in register t0 
		addi t1, zero, 10 #j in register t1
		
		addi sp, sp, -8 
		sw t0, 4(sp) #store word 
		sw t1, 0(sp) #store word
		
		add a1, zero, t0  #a1 = 0 + i 
		jal AddItUp 
		sw t1, A, s1
		
		lw t1, 0(sp)
		add a1, zero, t1
		jal AddItUp
		sw t1, B, s1
		
		addi sp, sp, 8 
		
		lw t0, A
		lw t1, B
		add t2, t0, t1 #t2 = t0 + t1
		sw t2, C, s1
		
		li a2,10			
		ecall
		
	AddItUp:
		add t0, zero, zero
		add t1, zero, zero
		
	for:	slt t3, t0, a1
		beqz t3, nvmFor #when t3 = 0 --> nvmFor
		addi t2, t0, 1   #t2 = t0 + 1 
		add t1, t1, t2   #t1 = t1+t2
		addi t0, t0, 1   #t0 = t0+1
		j for
	

	nvmFor:
		ret

