        # MIPS program that performs selection sort
        # It sort the array in ascending order
        # Written by Santiago Salazar
            
        .data
        .align  2
        
valueCount:  .word   4
values: .word   5,1,1,-3


#--------------------------------------------------------------------------------------------

        .text
        .globl  main

main:   la      $a0, valueCount     	# a0: get arraySize addr (n)
	la      $a1, values         	# a1: get array address
        
        li	$s0, 0		   	# s0: i = 0
	lw	$s1, valueCount     	# s1: n = arraysize
	addi	$s1, $s1, -1		# s1: n = n-1
                
loop:   bge	$s0,$s1, done		# while (i<n-1)
	move	$a2, $s0		# a2: min = i
        jal 	FindSmallest	    	# jumps to findSmallest Function		
        jal	swap
 	addi	$s0,$s0,1	    	# i++
 	j	loop		    	# Goes back to loop	       
        	

#-------------------------------------------------------------------------------------------- 
# findSmallest receives values (array) from register $a0, and min_index in the array from register $a1
# Finds the smallest integer in the received array
# Returns the smallest integer in the received array

FindSmallest:
	#--------------- Usual stuff at function beginning  ---------------
        addi    $sp, $sp, -12   # allocate stack space for 2 values
        sw      $ra, 0($sp)     # store off the return addr, etc 
        sw      $s0, 4($sp)	# s0: n
        sw      $s1, 8($sp)	# s1: array
       
        
        #------------------------ function body  ---------------------------
	move	$s0, $0 		# s0: index = 0
        move    $s1, $0			# s1: count = 0
        la      $s2, valueCount         # get valueCount addr
        lw      $s3, 0($s2)         	# s2: number of values in array (n)
        la      $s2, values         	# get array address
        move	$s6, $0			# s6: arrayPosIndex=  0
        li	$s7,99			# s7: lowestNum = 0
        
loop1:  bge     $s0, $s3, done1		# while (index < n)
        lw      $t0, 0($s2)		# t0 = next value in list
        
        blt 	$t0,$s7,true		# if(t0 <= s7)
	j cont        			# false, then go to cont
        
true:   move    $s7, $t0       # lowestNum = t0
	move	$s6,$s0		# arrayPosIndex = index 
	j cont

cont:	addi    $s0, $s0, 1     	# index++
        addi    $s2, $s2, 4     	# update address pointer
        j       loop1		
        
done1:  move    $a0, $s6            	# a0: lowestNumArrayIndex
	move	$a1, $a1		# a1: initial number in the array
  
	

	#--------------- Usual stuff at function end  ----------------------
	lw      $ra, 0($sp)         # restore the return address, etc
        lw      $s0, 4($sp)
        lw	$s1, 8($sp)
        addi    $sp, $sp, 12
        jr      $ra                 # return to the calling function

        
        
        
#--------------------------------------------------------------------------------------------
# Swap receives index of the array where the smallest
# integer is located, and swaps it 
# Returns the partially sorted array
swap:
	#--------------- Usual stuff at function beginning  ---------------
        addi    $sp, $sp, -12   # allocate stack space for 2 values
        sw      $ra, 0($sp)     # store off the return addr, etc 
	sw	$s0, 4($sp)	# a0: value index
	sw	$s1, 8($sp)	# a1: value of the first array integer
	
		#--------------- Function Body-------------#
	la	$t3, values	# gets array address
	li 	$t2, 0          # put the index into $t2
	add	$t2, $t2, $t2   # index = index *2
	add 	$t2, $t2, $t2   # index = index *2
	add 	$t1, $t2, $t3   # combine two components of the address
	lw 	$t4, 0($t1)     # get the value from the array cell
	move	$s0, $t4	# s0: temp values[0]
	
	sw	$a0, 0($t1)     # values[0] = value index
	
	move 	$t2, $a0        # put the index into $t2
	add	$t2, $t2, $t2   # index = index *2
	add 	$t2, $t2, $t2   # index = index *2
	add 	$t1, $t2, $t3   # combine the two components of the address
	lw 	$t4,  0($t1)    # get the value from the array cell
	
	sw	$s0, 0($t1)	# values[i] = temp
	
	#doesnt return anything	

	#--------------- Usual stuff at function end  ----------------------
	lw      $ra, 0($sp)         # restore the return address, etc
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        addi    $sp, $sp, 12
        jr      $ra                 # return to the calling function


done:   li      $v0, 10             # :D
        syscall                     
