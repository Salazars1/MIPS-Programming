        # MIPS program that performs modified Fibbonacci Recursively
        # Written by Santiago Salazar
            
        .data
        .align  2
        
	fprmpt: .asciiz "Enter the sequence index to compute the n modified Fibonacci sequence:" 


#--------------------------------------------------------------------------------------------

        .text
        .globl  main

main:	li $v0, 4		# Print prompt1
	la $a0, fprmpt
	syscall

	li $v0, 5		# Read input
	syscall

	move $a0, $v0		# Call fibonacci
	jal fibonacci
	move $a0, $v0 		# s5: return fibonacci

	
	li $v0, 1		# Print result
	syscall

	li $v0, 10		#:D
	syscall
	

fibonacci:
#--------------------- Usual stuff at function beginning  ----------------------
        addi    $sp, $sp, -12       # allocate stack space for 2 values
        sw      $ra, 0($sp)         # store off the return addr, etc 
        sw      $s0, 4($sp)
        sw	$s1, 8($sp)
        
        #----------------------function body------------------------------------
        
        move	$s0, $a0		# s0: receives n
        
        li	$t0, 1			# t0: Fo = 1
        li	$v0, 1
        ble	$s0, $t0, fiboDone	# if n > 1
        
        addi 	$a0, $s0, -1 		# a0: n--
	jal 	fibonacci		# fibonacci (n-1)
        move 	$s1, $v0 		# s1: stores return f(n-1)
        			
	addi 	$a0, $s0, -2 		# a0: n= n-2
	jal 	fibonacci		# fibonacci (n-2)
	mul 	$v0, $v0, 4		# v0: stores return f(n-2) * 4
	
	add 	$v0, $s1, $v0 		# adds result of f(n-1) to f(n-2)
	
fiboDone:
#--------------------- Usual stuff at function end  ---------------------------
	lw      $ra, 0($sp)         # restore the return address, etc
        lw      $s0, 4($sp)
        lw	$s1, 8($sp)
        addi    $sp, $sp, 12
        jr      $ra                 # return to the calling function


