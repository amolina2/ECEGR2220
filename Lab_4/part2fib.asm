.data
.text 

main: 
li a0, 3
jal Fibonacci 
add t1,zero,t0 

li a0,10 
jal Fibonacci 
add t2, zero t0  

li a0, 20
jal Fibonacci 
add s0, zero,t0 

j nomore  #end

Fibonacci:
li t5,1 
blez a0, vzero #if n=0
beq a0, t5, vone #if n=1 

addi sp,sp,-4
sw ra, 0(sp)
addi sp,sp,-4
sw a0,0(sp) 

addi a0,a0,-1
jal Fibonacci 

add a1,zero,t0 

lw a0,0(sp)
addi sp,sp,4
lw ra,0(sp)
addi sp,sp,4

addi sp,sp,-4
sw ra, 0(sp)
addi sp,sp,-4
sw a0,0(sp)
addi sp,sp,-4
sw a1,0(sp)

addi a0,a0,-2
jal Fibonacci 

add a2,zero,t0

 lw a1,0(sp)
 addi sp,sp,4
 lw a3 0(sp)
 addi sp,sp,4
 lw ra,0(sp)
 addi sp,sp,4
 
  add t0,a1,a2
  ret 
  
  vzero: 
  addi t0,zero,0
  ret
  
  vone:
  addi t0,zero,1
  ret
  
  nomore:
  li a7,10
  ecall 
  
  
    