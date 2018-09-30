        # MIPS program that performs modified Fibbonacci Recursively
        # Written by Santiago Salazar
            
        .data
        .align  2
        
	m: .asciiz "Enter m:" 
	n: .asciiz "Enter n:"

#--------------------------------------------------------------------------------------------

        .text
        .globl  main

main:
	li $v0, 4		# Prints "Enter m:"
	la $a0, m
	syscall
	li $v0, 5		# Reads input
	syscall
	move $a0, $v0
	move $s0, $a0
	
	move $s7,$s0
	
	li $v0, 4		# Prints "Enter n:"
	la $a0, n
	syscall
	li $v0, 5		# Read input
	syscall
	move $a1, $v0
	
	move $a0,$s0 
	jal Ackermann		# Calls Ackermann
	add $s5,$zero, $v0 	# s5: returns Ackermann computations
	
	
	move $a0,$s5
	li $v0, 1		# Prints result
	syscall

	li $v0, 10		#:D
	syscall
	

Ackermann:
#--------------------- Usual stuff at function beginning  ----------------------
        addi    $sp, $sp, -16       # allocate stack space for 2 values
        sw      $ra, 0($sp)    	    # store off the return addr     
        sw      $s0, 4($sp)	    # s0: m
        sw	$s1, 8($sp)	    # s1: n
        sw	$s2, 12($sp)	     
        #-----------=-----------function body------------------------------------
         
	move $s0,$a0
        move $s1,$a1
        
mZero:
        bne 	$s0, $zero, nZero	# branch if m == 0 
        addi 	$a1, $a1, 1		# n + 1
        move 	$v0, $a1
        j 	done 			
 
nZero:    	
        bne 	$s1, $zero, bothGreater	# if (n== 0) 
        addi 	$a0, $s0, -1 		# m-1	
        addi 	$a1, $zero, 1
       
        jal   	Ackermann   		# Ackermann(m-1, 1)  	
        j	done
        		
bothGreater:	
        move	$a0, $s0		# s0: m (for other call)
        addi 	$a1, $s1, -1	
        jal 	Ackermann		# Ackermann(m, (n -1))
	move 	$s1, $v0
        addi 	$a0, $s0, -1		# a0 = n - 1
        jal 	Ackermann		# Ackermann(m-1,A(m, (n - 1)))
       
      
#--------------------- Usual stuff at function end  ----------------------		
			
done:	
        lw 	$ra, 0($sp)
        lw 	$s0, 4($sp)
        lw	$s1, 8($sp)
        lw	$s2, 12($sp)	 
        addi 	$sp, $sp, 16
        		 
        jr 	$ra