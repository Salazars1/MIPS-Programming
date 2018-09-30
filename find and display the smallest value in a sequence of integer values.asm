        # find and display the smallest value in a sequence of 
        # integer values
        # Written by Santiago Salazar
            
        .data
        .align  2
        
valueCount:  .word   7
values: .word   1,2,3,-90,5,6,-4
out_string: .asciiz "         "

#---------------------------------------------------

        .text
        .globl  main

main:   move	$s0, $0 		# s0: index = 0
        move    $s1, $0			# s1: count = 0
        la      $s2, valueCount         # get valueCount addr
        lw      $s3, 0($s2)         # s2: number of values in array (n)
        la      $s2, values         # get array address
        move	$s6, $0			# s6: arrayPosIndex=  0
        move	$s7,$0			# s7: lowestNum = 0
        
loop:   bge     $s0, $s3, done      # while (index < n)
        lw      $t0, 0($s2)         # t0 = next value in list
        
        blt 	$t0,$s7,true		#if(t0 <= s7)
	j cont        			#false, then go to cont
        
true:   move     $s7, $t0       # lowestNum = t0
	move	$s6,$s0		# arrayPosIndex = index 
	j cont

cont:	addi    $s0, $s0, 1         # index++
        addi    $s2, $s2, 4         # update address pointer
        j       loop		
        
done:   move    $a0, $s6            # display lowestNumArrayIndex
        li      $v0, 1
        syscall

	move    $a0, $s7            # display lowestNum
        li      $v0, 1
        syscall
        
        li      $v0, 10             # :D
        syscall                     
