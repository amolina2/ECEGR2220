.data 
.text 

main: 
addi t6, t6, 1
li a0, 3
jal Fibonacci 
add



Fibonacci:
li t5, 1 
blez a0, vzero
beq a0, t6, vone 

