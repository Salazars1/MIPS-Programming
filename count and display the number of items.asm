        # Program to find the count of an specific number
        # Written by Santiago Salazar
            
        .data
        .align  2
        
arraySize:  .word   7
target: .word	2
values: .word   1,2,2,2,2,2,1
out_string: .asciiz "         "

#---------------------------------------------------

        .text
        .globl  main

main:   move	$s0, $0 		# s0: index = 0
        move    $s1, $0			# s1: count = 0
        la      $s2, arraySize          # get arraySize addr
        lw	$s4, target		# s4: target = 2
        lw      $s3, 0($s2)         # s2: number of values in array (n)
        la      $s2, values         # get array address
        
loop:   bge     $s0, $s3, done      # while (index < n)
        lw      $t0, 0($s2)         # t0 = next value in list
        
        beq 	$t0,$s4,true		#if(target==t0)
	j cont        			#false, then go to cont
        
true:   addi     $s1, $s1, 1       # count ++
	j cont

cont:	addi    $s0, $s0, 1         # index++
        addi    $s2, $s2, 4         # update address pointer
        j       loop		
        
done:   move    $a0, $s4            # display target
        li      $v0, 1
        syscall
        
        li 	$v0, 4 			# dislay white spaces
	la 	$a0, out_string 	
	syscall 			
        
        
        move    $a0, $s1            # display count
        li      $v0, 1
        syscall
        
        li      $v0, 10             # :D
        syscall                     
