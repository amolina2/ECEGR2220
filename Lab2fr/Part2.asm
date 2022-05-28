# Working with variables in memory

    .data   # Data declaration section

A:   .word   15
B:   .word   15
C:   .word   10
Z:   .word   0

    .text

main:       # Start of code section

	# Variable set up 
	lw  a0, A  # A--> a0
	lw  a1, B  # B --> a1
	lw  a2, C  # C --> a2
	la  a3, Z  # Z --> a3 
	

	slt t0, a0, a1 # A < B in t0
	addi t4, zero, 5  # t4 = 5
	sgt t1, a2, t4 # C > 5 in t1
	and s0, t0, t1 # (A < B) && (C > 5) in s0
	addi a6, zero, 1   # a6 = 1 
	addi t2, zero, 2   #t2 = 2
	addi t3, zero, 3   #t3 = 3
	
	# If Statement
	beq s0, zero, ElseIf #If s0(A<B && C>5)==0
	addi t6, zero, 1 # Z = 1
	j EndIf
	
	# ElseIf statement
ElseIf: slt s1, a1, a0 # A > B in s1  
	addi t5, a2, 1 # (C+1) in t5 
	addi a7, zero, 7 # a7 --> 7
	bne  t5, a7, Maybe #If t5 = a7 (C+1 = 7) 
	addi t6, zero, 2 #Z(a3) = 2
	j EndIf 
	
Maybe:   
	bne a6, s1, Oops   # 1 == A > B
	addi t6, zero, 2   # z(a3) = 2
	j EndIf

Oops:  addi t6, zero, 3   # z= 3 
	#j Exit 
EndIf:	
	beq t6, a6, case1
	beq t6, t2, case2
	beq t6, t3, case3

case1: neg t6, t6 
	j Exit
case2: neg t6, t6 
	j Exit
case3: neg t6, t6
	j Exit 
	
Exit: sw t6, 0(a3)


# END OF PROGRAM
