.data
prompt: .asciz "Enter a number: " 
tC: .asciz "Number in Celsius: "
tK: .asciz "Number in Kelvin: "
result: .asciz "\r\n"

f: .float 0 
c: .float 0 
k: .float 0 

addK: .float 273.15
.text 

main: 
flw fa0,f,t0
flw fa1,c,t0
flw fa2,k,t0

flw,ft3,addK,t0

li a7,4
la a0,prompt
ecall 


li a7,6
ecall

jal conC
jal conK

conC:
li t0,5
li t1,9
li t2,32

fcvt.s.w ft0,t0 
fcvt.s.w ft1,t1 
fcvt.s.w ft2,t2 

fsub.s fs2, fa0, ft2
fdiv.s fs3, ft0, ft1
fmul.s fa1, fs2, fs3

li a7, 4
la a0,tC
ecall 

li a7, 2
fmv.s fa0,fa1
ecall 
ret 

conK: 
flw ft3,addK, t0 
fadd.s fa0,fa0,ft3

li a7, 4
la a0, result
ecall

li a7, 4
la a0, tK
ecall

li a7, 2 
ecall

