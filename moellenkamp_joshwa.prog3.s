#############################################
## Name:  Joshwa Moellenkamp                #
## Email: jmolecavalier@gmail.com           #
#############################################
##                                          #
##  This program produces a Lucas sequence  #
##  of the first (U) or second (V) order,   #
##  given a number N, and constants         #
##  P and Q.                                #
##                                          #
############################################# 

.globl main

#############################################
#                                           #
#                   Data                    #
#                                           #
#############################################
.data
	menuWelcomeMessage: .asciiz "Lucas Sequence Generator: \n\n"
	menuOption1message:  .asciiz "  (1) U(n, P, Q)\n\n"
	menuOption2message:  .asciiz "  (2) V(n, P, Q)\n\n"
	menuOption3message:  .asciiz "  (3) Exit the program\n\n"	
	selectionMessage:    .asciiz "Enter your selection: "
	requestNmessage:	 .asciiz "Please enter integer  N: "
	requestPmessage:	 .asciiz "Please enter constant P: "
	requestQmessage:	 .asciiz "Please enter constant Q: "	
	newline:             .asciiz "\n"
	notYetImplemented:	 .asciiz "\nThis procedure is not yet implemented!\n"
	exitMessage:         .asciiz "\nThank you, come again!"
	
.text
#############################################
#                                           #
#                  Program                  #
#                                           #
#############################################
main:
	la $a0, menuWelcomeMessage	# load menu introductory message
	jal printString				# print message
	
	la $a0, menuOption1message	# load menu prompt 1
	jal printString				# print message
	
	la $a0, menuOption2message	# load menu prompt 2
	jal printString				# print message
	
	la $a0, menuOption3message	# load menu prompt 3
	jal printString				# print message
		
	la $a0, selectionMessage	# load message for menu selection input
	jal scanInteger			    # print selection prompt and get user input
	addi $a3, $v0, -1			# adjust result to make zero-indexed (0 or 1), 
	                            # and store value in $a3
	
	la $a0, newline          	# print a newline \n
	jal printString			
	
	li $t0, 1					# load temp value for range testing
	blt $t0, $a3, __sysExit		# user entered int > 2; exit program
	blt $a3, $0, __sysExit		# user entered int < 1; exit program
	
	la $a0, requestNmessage   	# load message to enter integer N
	jal scanInteger			    # print selection prompt and get user input
	move $s0, $v0				# store n in $s0 (for now)
	
	la $a0, requestPmessage   	# load message to enter integer P
	jal scanInteger			    # print selection prompt and get user input
	move $a1, $v0				# store P in $a1
	
	la $a0, requestQmessage   	# load message to enter integer Q
	jal scanInteger			    # print selection prompt and get user input
	move $a2, $v0				# store Q in $a2	
	
	move $a0, $s0				# copy n from $s0 to $a0
	
	jal lucasSequence			# print the lucas sequence for N, P, and Q

	la $a0, newline          	# print a newline \n
	jal printString		
	
	j main						# loop to main menu again


############################################# 
# Procedure: lucasSequence        		    #	
#############################################
#   - produces the Lucas sequence of the    #
#     first (U) or second (V) order for     #
#     given constants P and Q.              #
#                                           #
#     The procedure produces all numbers    #       
#     in the sequence U or V from n=0       #
#	  up to n=N.                     	    #
#                                           #
#   - inputs : $a0-integer N                #
#              $a1-constant P               #
#              $a2-constant Q               #
#              $a3-function U (0) or V (1)  #
#   - outputs: none                         #  
#										    #
#############################################	
lucasSequence:
	# $t0 will be used to determine if $a3 is equal to 1 (SEE WHAT I DID HERE?! WITH THE HAZARDS?!)
	addi	$t0, 	$0, 	1
	# Save the passed in arguments, N, P, & Q, into the s registers.
	sw		$a0,	$s2		# TODO: It's possible these won't be needed
	sw		$a1,	$s3
	sw		$a2,	$s4
	# Determine whether or not to run the U function.
	beq		$a3, 	$0, 	functionU
	# Determine whether or not to run the V function.
	beq		$a3, 	$t0,	functionV 
	# If neither of those statements branches, exit the program.
	j 		__sysExit

# Compute the U function.
functionU:
	# Place the n = 0 base case in $s0
	add 	$s0, 	$0, 	$0
	# Place the n = 1 base case in $s1
	addi 	$s1,	$0,		1
	
	# Need to specify the formula/base case here?

	# Begin the recursion by jumping to lucasSequenceNumber
	jal		lucasSequenceNumber

# Compute the V function.
functionV:
	# Place the n = 0 base case in $s0
	addi 	$s0, 	$0, 	2
	# Place the n = 1 base case in $s1
	add 	$s1,	$a1,	$0

	# Need to specify the formula/base case here?

	# Begin the recursion by jumping to lucasSequenceNumber
	jal lucasSequenceNumber`
	
############################################# 
# Procedure: lucasSequenceNumber        	#	
#############################################
#   - produces the Lucas number of the      #
#     first (U) and second (V) order for    #
#     number n, given constants P and Q.    #       
#										    #
#   - inputs : $a0-integer n                #
#              $a1-constant P               #
#              $a2-constant Q               #
#              $a3-function U (0) or V (1)  #
#   - outputs: $v0-value of U(n,P,Q) or     # 
#                  value of V(n,P,Q)        #
#										    #
#############################################	
lucasSequenceNumber:
	# Save necessary items on the stack.
	addi	$sp,	$sp, 	-12		# Make room for three variables
	sw		$ra, 	0($sp)
	sw		$s4, 	4($sp)			# $s4 is the value of P * f(n - 1) [This may also need to be revisited]
	sw		$s5, 	8($sp)			# $s5 is the value of Q * f(n - 2) [This may also need to be revisited]

	

	
	
    ###################################
    # Replace this code with your own #
	###################################
	la $a0, notYetImplemented	# not yet implemented message
	jal printString				# print message
	j __sysExit					# exit program
	
	
############################################# 
# Procedure: scanInteger         		    #	
#############################################
#   - prints a message and gets an integer  #
#     from user                             #
#										    #
#   - inputs : $a0-address of string prompt #
#   - outputs: $v0-integer return value     #  
#										    #
#############################################	
scanInteger:
	addi $sp, $sp, -4			# adjust stack
	sw $ra, 0($sp)				# push return address
	jal printString             # print message prompt
	
	li $v0, 5					# read integer from console
	syscall						

	lw $ra, 0($sp)				# pop return address
	addi $sp, $sp, 4			# adjust stack
	jr $ra						# return
	
############################################# 
# Procedure: printString   				    #	
#############################################
#   - print a string to console             #
#										    #
#   - inputs : $a0 - address of string      #
#   - outputs: none                         #  
#										    #
#############################################
printString:
	li $v0, 4
	syscall
	jr $ra	
	
############################################# 
# Procedure: __sysExit   				    #	
#############################################
#   - exit the program                      #
#										    #
#   - inputs : none                         #
#   - outputs: none                         #  
#										    #
#############################################
__sysExit:
	la $a0, exitMessage		# print exit message
	jal printString
	li $v0, 10				# exit program
	syscall

	