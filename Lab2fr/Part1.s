.data	# Data declaration section



z:	.word  0


.text

main:		# Start of code section

	addi	a1,zero, 15   #A(a1)= 15
	addi    a2,zero,10    #B(a2)= 10
	addi    a3,zero, 5    #C(a3) = 5
	addi    a4,zero, 2    #D(a4) = 2
	addi    a5,zero, 18   #E(a5) = 18
	addi    a6,zero, -3   #F(a6) = -3
	


FunctionA:
	sub t1, a1, a2	    # A - B (t1) 
        mul t2,a3, a4       # C * D  (t2)
        sub t3,a5,a6        # E - F (t3) 
        div t4,a1,a3        # A / C (t4)
        
        add t5, t1, t2      # (A-B) + (C*D)
        sub t6, t3,t4  	    # (E-F) - (A/C)
        
       
        add s2, t5, t6
        sw s2, z, t0 
   
           
	
# END OF PROGRAM
