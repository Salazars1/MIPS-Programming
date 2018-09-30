		#A First Foray with Functions
		#A program written by Santiago Salazar
		
		#a MIPS assembly program to compute n! Your program should utilize a
		#function that takes n as its input (precondition: n > 0) and returns n!
		
	.data
	.align 2
text:	.asciiz "n = "
answer:	.asciiz "n! = "
out_string: .asciiz "ERROR"

#_________________________________________________________________________________#
	.text
	.globl main
	
main:
	li 	$v0, 4		#Prints out text "n = "
    	la 	$a0, text
    	syscall
		
	li 	$v0, 5		# Getting user input
    	syscall
    	    	
    	move 	$s0, $v0	# s0: n = text (whatever the user types in)
    	move	$s1, $0		# s1: result
    	addi	$s1, $0, 1	# s1: result = 1		
    	
 	ble 	$s0,0, false	# if(n<=0) then jump to false 
 	jal 	factorial	# Call function
 	
 	move	$s1, $v0	#assigns whatever the function returned to s1
 	
 	li 	$v0, 4		#Prints out text "n = "
    	la 	$a0, answer
    	syscall
    	
 	move    $a0, $s1        # display return
        li      $v0, 1
        syscall

    	li 	$v0, 10		# End Program
    	syscall
 	 	
 	 	
 	 	
#_______________________________________________________________________________
 false:	li 	$v0, 4 		# dislay ERROR message
	la 	$a0, out_string 	
	syscall

    	li 	$v0, 10		# End Program
    	syscall
#_______________________________________________________________________________   	
 factorial:
	addi    $sp, $sp, -12	# allocate stack space for 2 values
 	sw	$ra, 4($sp)	# store off the return addr, etc.
 	sw	$s0, 0($sp)	# other regsiters	
	
	j loop 	
#_______________________________________________________________________________
loop:	blt	$s0,1,end	# while (n>=1)
    	mul	$s1, $s1 ,$s0	# result = result * n
    	addi 	$s0, $s0, -1	# n--
    	j	loop
    	
#_______________________________________________________________________________
end:	move	$v0, $s1	#return result 

	lw  	$ra, 4($sp)     # restore the return address and
        lw	$s0, 16($sp)	# other used registers...
        lw	$s1, 12($sp)
        addi	$sp, $sp, 24
        jr      $ra		# return to the calling function
    	
    	
    	

	
  		
    	
    	
    	
    	
    	