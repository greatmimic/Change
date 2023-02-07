#
#
#	Name:		Kang, Brian
#	Project:	#1
#	Due:		03/18/22
#	Course:		cs-2640-01-sp22
#	
#	Description:
#		Program that tells what coins to give out for any amount of change from 1 cent to 99 cents.
#


	.data
Title: .asciiz "Change by B. Kang\n"
Prompt: .asciiz "\nEnter the change? "
Q: .asciiz "\nQuarter: "
D: .asciiz "\nDime: "
N: .asciiz "\nNickel: "
P: .asciiz "\nPenny: "
nl: .asciiz "\n\n"


	.text
	
main: 
	la $a0, Title
	li $v0, 4        #print title
	syscall
	
	la $a0, Prompt 
	li $v0, 4		#print prompt
	syscall
	
	li $v0, 5		#take in user input
	syscall
	move $t0, $v0    #move user input into $t0
	
	#compute num of quarters
	
	div $t1, $t0, 25  #divide user input by 25
	mfhi $t2  #store remainder in $t1
	mflo $t3  #store quotient in $t3
	
	beqz $t3, dime  #if quotient of quarters is zero, branch to dime label
	
	la $a0, Q
	li $v0, 4 #print quarter output
	syscall
	move $a0, $t3 #move quotient to $a0 for print
	li $v0, 1
	syscall
	
	
dime:
	
	#compute num of dimes
	#$t2 has remainder from quarter
	
	div $t4, $t2, 10 
	mfhi $t2 #remainder
	mflo $t3 #quotient 
	
	beqz $t3, nickel #if quotient is zero, branch to nickel label
	
	la $a0, D
	li $v0, 4
	syscall
	move $a0, $t3 
	li $v0, 1
	syscall

	
nickel:

	#compute num of nickels
	#$t2 has remainder from dime
	
	div $t4, $t2, 5 
	mfhi $t2 #remainder
	mflo $t3 #quotient 
	
	beqz $t3, penny #if quotient is zero, branch to penny label
	
	la $a0, N
	li $v0, 4
	syscall
	move $a0, $t3
	li $v0, 1
	syscall

	
penny:
	#no computation is required as $t2 will have value already for penny label
	beqz $t2, end #if quotient is zero, branch to end label
	
	la $a0, P
	li $v0, 4
	syscall
	move $a0, $t2
	li $v0, 1
	syscall

	
end: 

	la $a0, nl
	li $v0, 4
	syscall
	li $v0, 10		#terminate
	syscall
	
	
	
