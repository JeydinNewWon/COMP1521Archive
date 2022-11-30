########################################################################
# COMP1521 22T3 -- Assignment 1 -- Battlesmips!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/22T3/resources/mips-editors.html
# !!! IMPORTANT !!!
#
# A simplified implementation of the classic board game battleship!
# This program was written by <Jayden Nguyen> (z5362408)
# on 10/10/2022
#
# Version 1.0 (2022/10/04): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
################################################################################

#![tabsize(8)]

# Constant definitions.
# DO NOT CHANGE THESE DEFINITIONS

# True and False constants
TRUE			= 1
FALSE			= 0
INVALID			= -1

# Board dimensions
BOARD_SIZE		= 7

# Bomb cell types
EMPTY			= '-'
HIT			= 'X'
MISS			= 'O'

# Ship cell types
CARRIER_SYMBOL		= 'C'
BATTLESHIP_SYMBOL	= 'B'
DESTROYER_SYMBOL	= 'D'
SUBMARINE_SYMBOL	= 'S'
PATROL_BOAT_SYMBOL	= 'P'

# Ship lengths
CARRIER_LEN		= 5
BATTLESHIP_LEN		= 4
DESTROYER_LEN		= 3
SUBMARINE_LEN		= 3
PATROL_BOAT_LEN		= 2

# Players
BLUE			= 'B'
RED			= 'R'

# Direction inputs
UP			= 'U'
DOWN			= 'D'
LEFT			= 'L'
RIGHT			= 'R'

# Winners
WINNER_NONE		= 0
WINNER_RED		= 1
WINNER_BLUE		= 2


################################################################################
# DATA SEGMENT
# DO NOT CHANGE THESE DEFINITIONS
.data

# char blue_board[BOARD_SIZE][BOARD_SIZE];
blue_board:			.space  BOARD_SIZE * BOARD_SIZE

# char red_board[BOARD_SIZE][BOARD_SIZE];
red_board:			.space  BOARD_SIZE * BOARD_SIZE

# char blue_view[BOARD_SIZE][BOARD_SIZE];
blue_view:			.space  BOARD_SIZE * BOARD_SIZE

# char red_view[BOARD_SIZE][BOARD_SIZE];
red_view:			.space  BOARD_SIZE * BOARD_SIZE

# char whose_turn = BLUE;
whose_turn:			.byte   BLUE

# point_t target;
.align 2
target:						# struct point target {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# point_t start;
.align 2
start:						# struct point start {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# point_t end;
.align 2
end:						# struct point end {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# Strings
red_player_name_str:		.asciiz "RED"
blue_player_name_str:		.asciiz "BLUE"
place_ships_str:		.asciiz ", place your ships!\n"
your_final_board_str:		.asciiz ", Your final board looks like:\n\n"
red_wins_str:			.asciiz "RED wins!\n"
blue_wins_str:			.asciiz "BLUE wins!\n"
red_turn_str:			.asciiz "It is RED's turn!\n"
blue_turn_str:			.asciiz "It is BLUE's turn!\n"
your_curr_board_str:		.asciiz "Your current board:\n"
ship_input_info_1_str:		.asciiz "Placing ship type "
ship_input_info_2_str:		.asciiz ", with length "
ship_input_info_3_str:		.asciiz ".\n"
enter_start_row_str:		.asciiz "Enter starting row: "
enter_start_col_str:		.asciiz "Enter starting column: "
enter_direction_str:		.asciiz "Enter direction (U, D, L, R): "
invalid_direction_str:		.asciiz "Invalid direction. Try again.\n"
invalid_length_str:		.asciiz "Ship doesn't fit in this direction. Try again.\n"
invalid_overlaps_str:		.asciiz "Ship overlaps with another ship. Try again.\n"
invalid_coords_already_hit_str:	.asciiz "You've already hit this target. Try again.\n"
invalid_coords_out_bounds_str:	.asciiz "Coordinates out of bounds. Try again.\n"
enter_row_target_str:		.asciiz "Please enter the row for your target: "
enter_col_target_str:		.asciiz "Please enter the column for your target: "
hit_successful_str: 		.asciiz "Successful hit!\n"
you_missed_str:			.asciiz "Miss!\n"


############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################


################################################################################
#
# Implement the following functions,
# and check these boxes as you finish implementing each function.
#
#  - [X] main
#  - [X] initialise_boards
#  - [X] initialise_board
#  - [X] setup_boards
#  - [X] setup_board
#  - [X] place_ship
#  - [X] is_coord_out_of_bounds
#  - [X] is_overlapping
#  - [X] place_ship_on_board
#  - [X] play_game
#  - [X] play_turn
#  - [X] perform_hit
#  - [X] check_player_win
#  - [X] check_winner
#  - [X] print_board			(provided for you)
#  - [X] swap_turn			(provided for you)
#  - [X] get_end_row			(provided for you)
#  - [X] get_end_col			(provided for you)
################################################################################

################################################################################
# .TEXT <main>
.text
main:
	# Args:     void
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [NONE]
	# Clobbers: [$v0]
	#
	# Locals:
	#   - ...
	# Description: 
	#	- This is the main function, where other successive functions
	#	  are called. It runs the main loop and responsible for the game
	#	  working. Returns 0 to indicate program exit.
	#
	# Structure:
	#   main
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

main__prologue:
	begin			# begin a new stack frame
	push		$ra		# | $ra

main__body:
	jal			initialise_boards
	jal 		setup_boards
	jal			play_game


main__epilogue:
	pop			$ra		# | $ra
	end			# ends the current stack frame

	li			$v0, 0
	jr			$ra		# return 0;


################################################################################
# .TEXT <initialise_boards>
.text
initialise_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0]
	# Clobbers: [$a0]
	#
	# Locals:
	#   - $a0 is the first arg for initialise_board, which
	#	- is simply the address to any board. 
	# Description:
	#	- Calls initialise_board on the four different boards
	#	that will be used in this program. 
	#
	# Structure:
	#   initialise_boards
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

initialise_boards__prologue:
	begin
	push		$ra

initialise_boards__body:
	la			$a0, blue_board					#	initialise_board(blue_board);
	jal			initialise_board

	la			$a0, blue_view					#	initialise_board(blue_view);
	jal			initialise_board

	la			$a0, red_board					#	initialise_board(red_board);
	jal			initialise_board

	la 			$a0, red_view					#	initialise_board(red_view);
	jal			initialise_board

initialise_boards__epilogue:
	pop			$ra
	end

	jr			$ra		# return;


################################################################################
# .TEXT <initialise_board>
.text
initialise_board:
	# Args:
        #   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $t0, $t1, $t2, $t3]
	# Clobbers: [$t0, $t1, $t2, $t3]
	#
	# Locals:
	#	- $t0: a temporary holder for $a0, the argument.
	#   - $t1: row counter in the row for loop.
	#	- $t2: a col counter in the col for loop.
	#	- $t3: used to store the address of a specific 
	#			element in the board. I.e. board[row][col]
	#	- $t4: holds the value of EMPTY, 
	#			so it can be stored into memory.
	# Description:
	#	- Loops through a given address to a particular board, and
	#	sets all of its elements equal to EMPTY. 
	#
	# Structure:
	#   initialise_board
	#   -> [prologue]
	#	-> initialise_board__body
	#   -> initialise_board__row_loop_init
	#	-> initialise_board__row_loop_cond
	#	-> initialise_board__row_loop_body
	#		-> initialise_board__col_loop_init
	#		-> initialise_board__col_loop_cond
	#		-> initialise_board__col_loop_body
	#		-> initialise_board__col_loop_step
	#		-> initialise_board__col_loop_end
	#	-> initialise_board__row_loop_step
	#	-> initialise_board__row_loop_end
	#   -> [epilogue]

initialise_board__prologue:
	begin
	push		$ra
	push		$a0

initialise_board__body:
	move		$t0, $a0

initialise_board__row_loop_init:
	li			$t1, 0

initialise_board__row_loop_cond:
	bge			$t1, BOARD_SIZE, initialise_board__row_loop_end		# 	for (int row = 0; row < BOARD_SIZE; row++) {

initialise_board__row_loop_body:
	
initialise_board__col_loop_init:
	li			$t2, 0

initialise_board__col_loop_cond:
	bge			$t2, BOARD_SIZE, initialise_board__col_loop_end		#	for (int col = 0; col < BOARD_SIZE; col++) {
	b			initialise_board__col_loop_body

initialise_board__col_loop_body:
	mul			$t3, $t1, BOARD_SIZE
	add			$t3, $t3, $t2
	add			$t3, $t3, $a0
	li			$t4, EMPTY

	sb			$t4, ($t3)											#	board[row][col] = EMPTY;

initialise_board__col_loop_step:
	addi		$t2, $t2, 1
	b			initialise_board__col_loop_cond

initialise_board__col_loop_end:
	b			initialise_board__row_loop_step

initialise_board__row_loop_step:
	addi		$t1, $t1, 1
	b			initialise_board__row_loop_cond

initialise_board__row_loop_end:
	b			initialise_board__epilogue

initialise_board__epilogue:
	pop			$a0
	pop			$ra
	end
	jr			$ra		# return;


################################################################################
# .TEXT <setup_boards>
.text
setup_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1]
	# Clobbers: [$a0, $a1]
	#
	# Locals:
	#   - $a0: used to store first argument for
	#			setup_board, which is a board address.
	#	- $a1: used to store second argument for
	#			setup_board, which is the player name.
	# Description:
	#	- Calls the setup_board function, for
	#	each of the given player names. 
	#
	# Structure:
	#   setup_boards
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

setup_boards__prologue:
	begin
	push		$ra
	push		$a0
	push		$a1

setup_boards__body:
	la			$a0, blue_board
	la			$a1, blue_player_name_str

	jal			setup_board						#	setup_board(blue_board, "BLUE");

	la			$a0, red_board
	la			$a1, red_player_name_str

	jal			setup_board						#	setup_board(red_board,  "RED");

setup_boards__epilogue:
	pop			$a1
	pop			$a0
	pop			$ra

	end
	jr			$ra		# return;


################################################################################
# .TEXT <setup_board>
.text
setup_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: char *player
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$a0, $a1, $s0, $s1]
	# Clobbers: [$a0, $a1, $s0, $s1, $v0]
	#
	# Locals:
	#   - $s0: stores the value of $a0, to prevent it from
	#			being lost as this function calls
	#			other functions.
	#	- $s1: stores the value of $a1, to prevent it from
	#			being lost as in the same case as $s0. 
	#
	# Description:
	#	- Sets up the board for each given player.
	#	To do so, it must prompt each player to place
	#	their ship on their board. This is done by
	#	calling the place_board function for each
	#	ship type. It then prints out what the
	#	final board looks like.
	#	
	# Structure:
	#   setup_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

setup_board__prologue:
	begin
	push		$ra
	push		$a0
	push		$a1
	push		$s0
	push		$s1

setup_board__body:
	move		$s0, $a0
	move		$s1, $a1


	move		$a0, $s1						# printf("%s, place your ships!\n", player);
	li 			$v0, 4							#
	syscall

	la 			$a0, place_ships_str			#
	syscall


	move		$a0, $s0						#
	li			$a1, CARRIER_LEN				# place_ship(board, CARRIER_LEN, CARRIER_SYMBOL);
	li			$a2, CARRIER_SYMBOL				#
	jal 		place_ship						#

	move		$a0, $s0
	li			$a1, BATTLESHIP_LEN				
	li			$a2, BATTLESHIP_SYMBOL
	jal			place_ship						# place_ship(board, BATTLESHIP_LEN, BATTLESHIP_SYMBOL);

	move		$a0, $s0
	li			$a1, DESTROYER_LEN
	li			$a2, DESTROYER_SYMBOL
	jal			place_ship						# place_ship(board, DESTROYER_LEN, DESTROYER_SYMBOL);


	move		$a0, $s0
	li			$a1, SUBMARINE_LEN
	li			$a2, SUBMARINE_SYMBOL
	jal			place_ship						# place_ship(board, SUBMARINE_LEN, SUBMARINE_SYMBOL);

	move		$a0, $s0
	li			$a1, PATROL_BOAT_LEN
	li			$a2, PATROL_BOAT_SYMBOL
	jal			place_ship						# place_ship(board, PATROL_BOAT_LEN, PATROL_BOAT_SYMBOL);

	# <place ship functions>


	move		$a0, $s1						# printf("%s, Your final board looks like:\n\n", player);
	li 			$v0, 4
	syscall
												#
	la			$a0, your_final_board_str		#
	syscall										#

	move		$a0, $s0
	jal			print_board

setup_board__epilogue:
	pop			$s1
	pop			$s0
	pop			$a1
	pop			$a0
	pop			$ra
	end

	jr			$ra		# return;


################################################################################
# .TEXT <place_ship>
.text
place_ship:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: int  ship_len
	#   - $a2: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$a0, $a1, $a2, $t0, $t1, $t2]
	# Clobbers: [$t0, $t1, $t2, $a0, $a1, $a2, $s0, $s1, $s2, $s3, $v0]
	#
	# Locals:
	#	- $t0: temporary value
	#   - $t1: temporary value
	#	- $t2: saves the value 4, to increment 
	#			addresses to access structs.
	#	- $s0: saves board
	#	- $s1: saves ship_len
	#	- $s2: saves ship_type
	#	- $s2: saves direction_char
	#
	# Description:
	#	- This function performs the action of placing a ship
	#	onto a player board. However, it goes through several
	#	steps of validation to ensure that the inputs are 
	#	reasonable. This is done by calling out_of_bounds
	#	functions and calling is_overlapping. It then
	#	assigns an appropriate end_row and end_col 
	#	by calling get_end_row and get_end_col.
	#
	# Structure:
	#   place_ship
	#   -> [prologue]
	#   -> body
	#	-> place_ship__for_loop
	#		-> place_ship__for_loop_init_prints
	#		-> place_ship__for_loop_scan_in_start
	#		-> place_ship__for_loop_scan_in_start_out_bounds
	#		-> place_ship__for_loop_scan_in_direction
	#		-> place_ship__for_loop_invalid_direction
	#		-> place_ship__for_loop_coord_out_bounds
	#		-> place_ship__for_loop_start_end_edit_1
	#			-> place_ship__for_loop_start_row_greater
	#		-> place_ship__for_loop_start_end_edit_2
	#			-> place_ship__for_loop_start_col_greater
	#		-> place_ship__for_loop_is_overlapping
	#		-> place_ship__for_loop_end
	#   -> [epilogue]

place_ship__prologue:
	begin

	push		$ra
	push		$a0
	push		$a1
	push		$a2
	push		$s0
	push		$s1
	push		$s2
	push		$s3

place_ship__body:
	move		$s0, $a0	# 	save the arguments in the s-registers
	move		$s1, $a1
	move		$s2, $a2

place_ship__for_loop:						# 	for (;;) {

place_ship__for_loop_init_prints:			# 	the initial printing
	la			$a0, your_curr_board_str	# 	printf("Your current board:\n");
	li			$v0, 4
	syscall

	move		$a0, $s0					# 	print_board(board);
	jal			print_board

	la			$a0, ship_input_info_1_str	# 	printf("Placing ship type
	li			$v0, 4
	syscall

	move		$a0, $s2					# 	%c
	li			$v0, 11
	syscall

	la			$a0, ship_input_info_2_str	# 	with length 
	li			$v0, 4
	syscall		

	move		$a0, $s1					# 	%d.
	li			$v0, 1
	syscall

	la 			$a0, ship_input_info_3_str	#	\n", ship_type, ship_len);
	li			$v0, 4
	syscall

	b			place_ship__for_loop_scan_in_start

	
place_ship__for_loop_scan_in_start:
	la 			$a0, enter_start_row_str	# 	printf("Enter starting row: ");
	li			$v0, 4
	syscall

	li			$v0, 5						# 	scanf("%d", &start.row);
	syscall 

	la			$t0, start					# 	stores into start.row
	sw			$v0, ($t0)

	la			$a0, enter_start_col_str	# 	printf("Enter starting column: ");
	li			$v0, 4
	syscall

	li			$v0, 5						# 	scanf("%d", &start.col);
	syscall 

	addi		$t0, $t0, 4					# 	stores into start.col
	sw			$v0, ($t0)

	la			$a0, start					#   if (is_coord_out_of_bounds(&start))
	jal			is_coord_out_of_bounds

	beq			$v0, TRUE, place_ship__for_loop_scan_in_start_out_bounds

	b 			place_ship__for_loop_scan_in_direction

place_ship__for_loop_scan_in_start_out_bounds:
	la			$a0, invalid_coords_out_bounds_str		#	printf("Coordinates out of bounds. Try again.\n");
	li			$v0, 4									# 	continue
	syscall
	b			place_ship__for_loop

place_ship__for_loop_scan_in_direction:					# 	now we scan in the directions.
	la			$a0, enter_direction_str				# 	printf("Enter direction (U, D, L, R): ");
	li			$v0, 4
	syscall

	li			$v0, 12									# 	scanf(" %c", &direction_char);
	syscall

	move		$s3, $v0								# 	save the direction

	lw			$a0, start								#	get start.row
	move		$a1, $s3								#	s3 = direction_char
	move		$a2, $s1								#	s1 = ship_len

	jal			get_end_row								#	end.row = get_end_row(start.row, direction_char, ship_len);
	
	sw			$v0, end

	li			$t2, 4

	lw			$a0, start($t2)
	move		$a1, $s3								#	s3 = direction_char
	move		$a2, $s1								

	jal			get_end_col			

	sw			$v0, end($t2)							#	end.col = get_end_col(start.col, direction_char, ship_len);

	lw			$t0, end
	lw			$t1, end($t2)

	beq			$t0, INVALID, place_ship__for_loop_invalid_direction		# 	if (end.row == INVALID || end.col == INVALID) {
	beq			$t1, INVALID, place_ship__for_loop_invalid_direction		

	la			$a0, end
	jal			is_coord_out_of_bounds

	beq			$v0, TRUE, place_ship__for_loop_coord_out_bounds	# 	if (is_coord_out_of_bounds(&end)) {

	b			place_ship__for_loop_start_end_edit_1

place_ship__for_loop_invalid_direction:
	la			$a0, invalid_direction_str							# 	printf("Invalid direction. Try again.\n");
	li			$v0, 4
	syscall
	b			place_ship__for_loop

place_ship__for_loop_coord_out_bounds:
	la			$a0, invalid_length_str								#	printf("Ship doesn't fit in this direction. Try again.\n");
	li			$v0, 4
	syscall
	b 			place_ship__for_loop


place_ship__for_loop_start_end_edit_1:
	lw			$t0, start												# 	t0 = start.row
	lw			$t1, end												# 	t1 = end.row

	bgt			$t0, $t1, place_ship__for_loop_start_row_greater		# 	if (start.row > end.row) {

	b			place_ship__for_loop_start_end_edit_2

place_ship__for_loop_start_row_greater:
	sw			$t1, start
	sw			$t0, end

place_ship__for_loop_start_end_edit_2:
	lw			$t0, start($t2)											# t0 = start.col
	lw			$t1, end($t2)											# t1 = end.col

	bgt			$t0, $t1, place_ship__for_loop_start_col_greater		# if (start.col > end.col) {

	b			place_ship__for_loop_is_overlapping

place_ship__for_loop_start_col_greater:
	sw			$t1, start($t2)
	sw			$t0, end($t2)

place_ship__for_loop_is_overlapping:									# if (!is_overlapping(board)) {
	move		$a0, $s0
	jal			is_overlapping

	beq			$v0, FALSE, place_ship__for_loop_end

	la			$a0, invalid_overlaps_str
	li			$v0, 4
	syscall

	b			place_ship__for_loop
	
place_ship__for_loop_end:

	move		$a0, $s0
	move		$a1, $s2												# place_ship_on_board(board, ship_type);

	jal			place_ship_on_board


place_ship__epilogue:
	pop 		$s3 
	pop			$s2
	pop			$s1
	pop			$s0
	pop			$a2
	pop			$a1
	pop			$a0
	pop			$ra

	end
	jr			$ra		# return;


################################################################################
# .TEXT <is_coord_out_of_bounds>
.text
is_coord_out_of_bounds:
	# Args:
	#   - $a0: point_t *coord
	#
	# Returns:
	#   - $v0: bool
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $t0]
	# Clobbers: [$t0, $v0]
	#
	# Locals:
	#   - $t0: coord->row and coord->column
	#
	# Description:
	#	- Checks if a row or column is out
	#	of the boundaries of BOARD_SIZE.
	#	Returns TRUE or FALSE.
	#
	# Structure:
	#   is_coord_out_of_bounds
	#   -> [prologue]
	#   -> body
	#	-> is_coord_out_of_bounds__return_true
	#	-> is_coord_out_of_bounds__return_false
	#   -> [epilogue]

is_coord_out_of_bounds__prologue:
	begin
	push		$ra
	push		$a0

is_coord_out_of_bounds__body:
	lw			$t0, ($a0)

	blt			$t0, 0, is_coord_out_of_bounds__return_true				# if (coord->row < 0 || coord->row >= BOARD_SIZE) {
	bge			$t0, BOARD_SIZE, is_coord_out_of_bounds__return_true

	lw			$t0, 4($a0)

	blt			$t0, 0, is_coord_out_of_bounds__return_true
	bge			$t0, BOARD_SIZE, is_coord_out_of_bounds__return_true	# if (coord->col < 0 || coord->col >= BOARD_SIZE) {


	b 			is_coord_out_of_bounds__return_false


is_coord_out_of_bounds__return_true:
	li			$v0, TRUE
	b			is_coord_out_of_bounds__epilogue						# return TRUE

is_coord_out_of_bounds__return_false:
	li			$v0, FALSE
	b			is_coord_out_of_bounds__epilogue						# return FALSE

is_coord_out_of_bounds__epilogue:
	pop			$a0
	pop			$ra
	end 

	jr			$ra		# return;


################################################################################
# .TEXT <is_overlapping>
.text
is_overlapping:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:
	#   - $v0: bool
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $t0, $t1, $t2, $t3, $t4, $t5]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:
	#   - $t0: start.row
	#	- $t1: end.row
	#	- $t2: start.col -> col
	#	- $t3: end.col
	#	- $t4: temporary value (stores addresses and adds/multiplies them) 
	#	- $t5: board[start.row][col] OR board[row][start.col]
	#	- $t6: holds increment value 4 
	#
	# Description:
	#	- Checks if a ship is overlapping with another
	#	ship. Returns TRUE or FALSE.
	#
	# Structure:
	#   is_overlapping
	#   -> [prologue]
	#   -> body
	#	-> is_overlapping__for_loop_start_equals_end_init
	#	-> is_overlapping__for_loop_start_equals_end_cond
	#	-> is_overlapping__for_loop_start_equals_end_body
	#	-> is_overlapping__for_loop_start_equals_end_step
	#	-> is_overlapping__for_loop_start_equals_end_end
	#	-> ----
	#	-> is_overlapping__for_loop_else_if
	#	-> is_overlapping__for_loop_else_if_init
	#	-> is_overlapping__for_loop_else_if_cond
	#	-> is_overlapping__for_loop_else_if_body
	#	-> is_overlapping__for_loop_else_if_step
	#	-> is_overlapping__for_loop_else_if_end
	#	-> is_overlapping__return_true
	#	-> is_overlapping__return_false
	#   -> [epilogue]

is_overlapping__prologue:
	begin
	push		$ra
	push		$a0

is_overlapping__body:
	lw			$t0, start
	lw			$t1, end
	li			$t6, 4

	beq			$t0, $t1, is_overlapping__for_loop_start_equals_end_init 		# if (start.row == end.row) {

	b 			is_overlapping__for_loop_else_if

is_overlapping__for_loop_start_equals_end_init:
	lw			$t2, start($t6)													# int col = start.col
	lw			$t3, end($t6)

is_overlapping__for_loop_start_equals_end_cond:
	bgt			$t2, $t3, is_overlapping__for_loop_start_equals_end_end			# for (int col = start.col; col <= end.col; col++) {

is_overlapping__for_loop_start_equals_end_body:
	mul			$t4, $t0, BOARD_SIZE
	add			$t4, $t4, $t2
	add			$t4, $t4, $a0

	lb			$t5, ($t4)

	bne			$t5, EMPTY, is_overlapping__return_true							# if (board[start.row][col] != EMPTY) {

is_overlapping__for_loop_start_equals_end_step:
	addi		$t2, $t2, 1
	b			is_overlapping__for_loop_start_equals_end_cond

is_overlapping__for_loop_start_equals_end_end:
	b			is_overlapping__return_false

is_overlapping__for_loop_else_if:

is_overlapping__for_loop_else_if_init:
	lw			$t2, start($t6)													# int col = start.col
	lw			$t3, end($t6)

is_overlapping__for_loop_else_if_cond:
	bgt			$t0, $t1, is_overlapping__for_loop_else_if_end					# for (int row = start.row; row <= end.row; row++) {

is_overlapping__for_loop_else_if_body:
	mul			$t4, $t0, BOARD_SIZE
	add			$t4, $t4, $t2
	add			$t4, $t4, $a0
	

	lb			$t5, ($t4)

	bne			$t5, EMPTY, is_overlapping__return_true							# if (board[row][start.col] != EMPTY) {

is_overlapping__for_loop_else_if_step:
	addi		$t0, $t0, 1
	b  			is_overlapping__for_loop_else_if_cond

is_overlapping__for_loop_else_if_end:
	b			is_overlapping__return_false


is_overlapping__return_true:													# return TRUE;
	li			$v0, TRUE
	b			is_overlapping__epilogue

is_overlapping__return_false:													# return FALSE;
	li			$v0, FALSE
	b			is_overlapping__epilogue

is_overlapping__epilogue:

	pop			$a0
	pop			$ra
	end

	jr			$ra		# return;


################################################################################
# .TEXT <place_ship_on_board>
.text
place_ship_on_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:
	#   - $t0: start.row
	#	- $t1: end.row
	#	- $t2: start.col 
	#	- $t3: end.col
	#	- $t4: temp value
	#	- $t5: holds increment value 4
	#
	# Description:
	#	- This function actually does the task of
	#	placing a given ship onto a board. This
	#	is called after the validation processes
	#	in the place_ship function has been completed. 
	#
	# Structure:
	#   place_ship_on_board
	#   -> [prologue]
	#   -> body
	#	-> place_ship_on_board__for_loop_start_equals_end_init
	#	-> place_ship_on_board__for_loop_start_equals_end_cond
	#	-> place_ship_on_board__for_loop_start_equals_end_body
	#	-> place_ship_on_board__for_loop_start_equals_end_step
	#	-> place_ship_on_board__for_loop_start_equals_end_end
	#	-----------
	#	-> place_ship_on_board__for_loop_else_if
	#	-> place_ship_on_board__for_loop_else_if_init
	#	-> place_ship_on_board__for_loop_else_if_cond
	#	-> place_ship_on_board__for_loop_else_if_body
	#	-> place_ship_on_board__for_loop_else_if_step
	#	-> place_ship_on_board__for_loop_else_if_end
	#   -> [epilogue]

place_ship_on_board__prologue:
	begin
	push		$ra
	push		$a0
	push		$a1

place_ship_on_board__body:
	lw			$t0, start
	lw			$t1, end
	li			$t5, 4

	lw			$t2, start($t5)
	lw			$t3, end($t5)

	beq			$t0, $t1, place_ship_on_board__for_loop_start_equals_end_init	# if (start.row == end.row)

	b			place_ship_on_board__for_loop_else_if

place_ship_on_board__for_loop_start_equals_end_init:

place_ship_on_board__for_loop_start_equals_end_cond:							# for (int col = start.col; col <= end.col; col++) {
	bgt			$t2, $t3, place_ship_on_board__for_loop_start_equals_end_end
	b 			place_ship_on_board__for_loop_start_equals_end_body

place_ship_on_board__for_loop_start_equals_end_body:							
	mul			$t4, $t0, BOARD_SIZE
	add			$t4, $t4, $t2
	add			$t4, $t4, $a0

	sb			$a1, ($t4)														# board[start.row][col] = ship_type;

place_ship_on_board__for_loop_start_equals_end_step:
	addi		$t2, $t2, 1
	b			place_ship_on_board__for_loop_start_equals_end_cond

place_ship_on_board__for_loop_start_equals_end_end:
	b			place_ship_on_board__epilogue

place_ship_on_board__for_loop_else_if:											# else 

place_ship_on_board__for_loop_else_if_init:

place_ship_on_board__for_loop_else_if_cond:										# for (int row = start.row; row <= end.row; row++) {
	bgt			$t0, $t1, place_ship_on_board__for_loop_else_if_end
	b 			place_ship_on_board__for_loop_else_if_body

place_ship_on_board__for_loop_else_if_body:
	mul			$t4, $t0, BOARD_SIZE
	add			$t4, $t4, $t2
	add			$t4, $t4, $a0

	sb			$a1, ($t4)														# board[row][start.col] = ship_type;

place_ship_on_board__for_loop_else_if_step:
	addi		$t0, $t0, 1
	b			place_ship_on_board__for_loop_else_if_cond

place_ship_on_board__for_loop_else_if_end:
	b			place_ship_on_board__epilogue

place_ship_on_board__epilogue:
	pop			$a1
	pop			$a0
	pop			$ra
	end

	jr			$ra		# return;


################################################################################
# .TEXT <play_game>
.text
play_game:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$s0, $ra]
	# Uses:     [$s0, $v0]
	# Clobbers: [$a0, $s0]
	#
	# Locals:
	#   - $s0: stores the state of WINNER
	#	- $a0: changed to print strings.
	#
	# Description:
	#	- This is called after the boards for both 
	#	players have been set up. This runs an infinite 
	#	loop until a winner is identified by calling
	#	the check_winner function. The program
	#	terminates and then prints the correct winner 
	#	if they are found.
	#
	# Structure:
	#   play_game
	#   -> [prologue]
	#   -> body
	#	-> play_game__loop_init
	#	-> play_game__loop_cond
	#	-> play_game__loop_body
	#	-> play_game__loop_end
	#	-> play_game__red_wins
	#	-> play_game__blue_wins
	#   -> [epilogue]

play_game__prologue:
	begin
	push		$ra
	push		$s0


play_game__body:
	
play_game__loop_init:
	li			$s0, WINNER_NONE

play_game__loop_cond:
	bne			$s0, WINNER_NONE, play_game__loop_end			# while (winner == WINNER_NONE) {

play_game__loop_body:
	jal			play_turn										# play_turn();

	jal			check_winner
	move		$s0, $v0										# winner = check_winner();

	b			play_game__loop_cond

play_game__loop_end:
	beq			$s0, WINNER_RED, play_game__red_wins			# if (winner == WINNER_RED) {

	b			play_game__blue_wins
play_game__red_wins:
	la			$a0, red_wins_str
	li			$v0, 4
	syscall														# printf("RED wins!\n");

	b			play_game__epilogue

play_game__blue_wins:
	la			$a0, blue_wins_str
	li			$v0, 4
	syscall														# printf("BLUE wins!\n");

	b 			play_game__epilogue

play_game__epilogue:

	pop 		$s0
	pop			$ra
	end

	jr			$ra		# return;


################################################################################
# .TEXT <play_turn>
.text
play_turn:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$t0, $t1]
	# Clobbers: [$a0, $t0, $t1, $v0]
	#
	# Locals:
	#   - $t0: holds the value of whose_turn
	#	- $t1: stores 4, a value to increment the target.row address
	#
	# Description:
	#	- This function is called when in the play_game
	#	loop for each turn of the game. It keeps calling 
	#	until play_game finds a winner. It reads in input
	#	from the user, it calls perform_hit to hit a 
	#	specific point on the enemy player's board. 
	#	
	#	If a player manages to score a successful hit,
	# 	they are rewarded with another turn until they miss.
	#	This means that swap_turn is only called when
	#	a player misses.
	#	
	#
	# Structure:
	#   play_turn
	#   -> [prologue]
	#   -> body
	#	-> play_turn__blue_turn
	#	-> play_turn__red_turn
	#	-> play_turn__scan_target
	#	-> play_turn__perform_hit_section
	#	-> play_turn__perform_hit_blue
	#	-> play_turn__perform_hit_red
	#	-> play_turn__hit_status
	#	-> play_turn__invalid
	#	-> play_turn__hit
	#	-> play_turn__out_of_bounds
	#   -> [epilogue]

play_turn__prologue:
	begin
	push		$ra

play_turn__body:
	lb			$t0, whose_turn

	beq			$t0, BLUE, play_turn__blue_turn				#	if (whose_turn == BLUE) {

	b			play_turn__red_turn

play_turn__blue_turn:
	la			$a0, blue_turn_str							#	printf("It is BLUE's turn!\n");			
	li			$v0, 4
	syscall

	la			$a0, blue_view	
	jal			print_board									#	print_board(blue_view);

	b			play_turn__scan_target

play_turn__red_turn:
	la			$a0, red_turn_str							#	printf("It is RED's turn!\n");
	li			$v0, 4
	syscall

	la			$a0, red_view								#	print_board(red_view);
	jal			print_board

	b			play_turn__scan_target

play_turn__scan_target:
	li			$t1, 4									#	increments to access end.col

	la			$a0, enter_row_target_str				#	printf("Please enter the row for your target: ");
	li			$v0, 4									
	syscall

	li			$v0, 5									#	scanf("%d", &target.row);
	syscall

	sw			$v0, target

	la			$a0, enter_col_target_str				#	printf("Please enter the column for your target: ");
	li			$v0, 4
	syscall

	li			$v0, 5									#	scanf("%d", &target.col);
	syscall

	sw			$v0, target($t1)

	la			$a0, target
	jal			is_coord_out_of_bounds

	beq			$v0, TRUE, play_turn__out_of_bounds		#	if (is_coord_out_of_bounds(&target)) {

play_turn__perform_hit_section:
	lb			$t0, whose_turn
	beq 		$t0, BLUE, play_turn__perform_hit_blue	#	if (whose_turn == BLUE) {

	b			play_turn__perform_hit_red


play_turn__perform_hit_blue:
	la			$a0, red_board
	la			$a1, blue_view

	jal			perform_hit

	b			play_turn__hit_status

play_turn__perform_hit_red:
	la			$a0, blue_board
	la			$a1, red_view

	jal			perform_hit

	b			play_turn__hit_status

play_turn__hit_status:
	beq			$v0, INVALID, play_turn__invalid		#	if (hit_status == INVALID) {

	beq			$v0, HIT, play_turn__hit				#	if (hit_status == HIT) {

	la			$a0, you_missed_str						#	printf("Miss!\n");
	li			$v0, 4
	syscall

	jal			swap_turn								#	swap_turn();		

	b			play_turn__epilogue

play_turn__invalid:
	la			$a0, invalid_coords_already_hit_str		#	printf("You've already hit this target. Try again.\n");
	li			$v0, 4
	syscall

	b			play_turn__epilogue

play_turn__hit:
	la			$a0, hit_successful_str					#	printf("Successful hit!\n");
	li			$v0, 4
	syscall

	b			play_turn__epilogue



play_turn__out_of_bounds:	
	la			$a0, invalid_coords_out_bounds_str		# 	printf("Coordinates out of bounds. Try again.\n");
	li			$v0, 4
	syscall

	b			play_turn__epilogue	


play_turn__epilogue:
	pop			$ra
	end

	jr			$ra		# return 0;


################################################################################
# .TEXT <perform_hit>
.text
perform_hit:
	# Args:
	#   - $a0: char their_board[BOARD_SIZE][BOARD_SIZE]
	#   - $a1: char our_view[BOARD_SIZE][BOARD_SIZE]
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:
	#   - $t0: holds the value of target.row
	#	- $t1: holds the value of target.col
	#	- $t2: holds 4, which increments the target address
	#	- $t3: holds the address to our_view[target.row][target.col]
	#	- $t4: holds the address to their_view[target.row][target.col]
	#	- $t5: holds the result of anything at $t3 or $t4, and is a temporary value
	#
	# Description:
	#	- Actually performs a hit. It takes in two boards and reads 
	#	the target value. It returns HIT if successful and saves 
	#	it to memory, MISS if unsuccessful and INVALID 
	#	if a player chooses a point that was already HIT before.
	#
	# Structure:
	#   perform_hit
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

perform_hit__prologue:
	begin
	push		$ra

perform_hit__body:
	li			$t2, 4

	lw			$t0, target
	lw			$t1, target($t2)

	mul			$t3, $t0, BOARD_SIZE
	add			$t3, $t3, $t1
	add			$t3, $t3, $a1

	lb			$t5, ($t3)

	bne			$t5, EMPTY, perform_hit__return_invalid					#	if (our_view[target.row][target.col] != EMPTY) {

	mul			$t4, $t0, BOARD_SIZE
	add			$t4, $t4, $t1
	add			$t4, $t4, $a0

	lb			$t5, ($t4)

	bne			$t5, EMPTY, perform_hit__return_hit						#	if (their_board[target.row][target.col] != EMPTY) {

	b			perform_hit__return_miss


perform_hit__return_invalid:
	li			$v0, INVALID 											#	return INVALID;
	b			perform_hit__epilogue

perform_hit__return_hit:
	li			$t5, HIT

	sb			$t5, ($t3)												#	our_view[target.row][target.col] = HIT;
	li			$v0, HIT												#	return HIT;
	b			perform_hit__epilogue
perform_hit__return_miss:
	li			$t5, MISS
	sb			$t5, ($t3)												#	our_view[target.row][target.col] = MISS;

	li			$v0, MISS												#	return MISS;
	b			perform_hit__epilogue

perform_hit__epilogue:
	pop			$ra
	end
	jr			$ra		# return;


################################################################################
# .TEXT <check_winner>
.text
check_winner:
	# Args:	    void
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [$a0, $a1, $v0]
	#
	# Locals:
	#   - $a0: is clobbered to call check_player_win, takes in a specific board.
	#	- $a1: is clobbered to call check_player_win, takes in the player's view.
	#
	# Description:
	#	- This program checks if a player has won.
	#	It calls check_player_win, and depending
	#	on the result, returns WINNER_RED if red wins,
	#	WINNER BLUE if blue wins, and WINNER_NONE if
	#	neither has won the game yet.
	#
	# Structure:
	#   check_winner
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

check_winner__prologue:
	begin
	push		$ra

check_winner__body:
	la			$a0, red_board
	la			$a1, blue_view

	jal			check_player_win

	beq			$v0, TRUE, check_winner__blue_wins		# if (check_player_win(red_board, blue_view)) {

	la			$a0, blue_board
	la			$a1, red_view

	jal			check_player_win

	beq			$v0, TRUE, check_winner__red_wins		# if (check_player_win(blue_board, red_view)) {

	li			$v0, WINNER_NONE
	b			check_winner__epilogue


check_winner__blue_wins:
	li			$v0, WINNER_BLUE
	b			check_winner__epilogue					# return WINNER_BLUE;

check_winner__red_wins:
	li			$v0, WINNER_RED
	b			check_player_win__epilogue				# return WINNER_RED;


check_winner__epilogue:
	pop			$ra
	end
	jr			$ra										# return;


################################################################################
# .TEXT <check_player_win>
.text
check_player_win:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] their_board
	#   - $a1: char[BOARD_SIZE][BOARD_SIZE] our_view
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5, $t6]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $t5, $t6]
	#
	# Locals:
	#   - $t0: 	row
	#	- $t1: 	col
	#	- $t2: 	stores the sum of BOARD_SIZE * row + col, 
	#			which gives the amount of displacement to access
	#			their_board[row][col] and our_view[row][col] 
	#	- $t3: 	address of their_board[row][col]
	#	- $t4:	address of our_view[row][col]
	#	- $t5: 	value at their_board[row][col]
	#	- $t6: 	value at our_view[row][col]
	#
	# Description:
	#	- This function actually determines if a player has won.
	#	It checks if all the elements in the enemy's board that 
	#	are not EMPTY, is matched with the exact same point
	#	on the view of the current player. If there are no 
	#	elements for which the current player has not missed, 
	#	then they win. Returns TRUE or FALSE.
	#
	# Structure:
	#   check_player_win
	#   -> [prologue]
	#   -> body
	#	-> check_player__row_loop_init
	#	-> check_player__row_loop_cond
	#	-> check_player__row_loop_body
	#		-> check_player__col_loop_init
	#		-> check_player__col_loop_cond
	#		-> check_player__col_loop_body
	#			-> check_player_verify_our_view
	#		-> check_player__col_loop_step
	#		-> check_player__col_loop_end
	#	-> check_player__row_loop_step
	#	-> check_player__row_loop_end
	#	-> check_player__return_false
	#   -> [epilogue]

check_player_win__prologue:
	begin 
	push		$ra

check_player_win__body:

check_player__row_loop_init:
	li			$t0, 0

check_player__row_loop_cond:
	bge			$t0, BOARD_SIZE, check_player__row_loop_end					# for (int row = 0; row < BOARD_SIZE; row++) {

check_player__row_loop_body:

check_player__col_loop_init:
	li			$t1, 0

check_player__col_loop_cond:
	bge			$t1, BOARD_SIZE, check_player__col_loop_end					# for (int col = 0; col < BOARD_SIZE; col++) {

check_player__col_loop_body:
	mul			$t2, $t0, BOARD_SIZE
	add			$t2, $t2, $t1

	add			$t3, $t2, $a0
	add			$t4, $t2, $a1

	lb			$t5, ($t3)
	lb			$t6, ($t4)

	bne			$t5, EMPTY, check_player_verify_our_view					# if (their_board[row][col] != EMPTY 
	b			check_player__col_loop_step

check_player_verify_our_view: 
	beq			$t6, EMPTY, check_player__return_false					 	# && our_view[row][col] == EMPTY) {
	b			check_player__col_loop_step

check_player__col_loop_step:
	addi		$t1, $t1, 1
	b			check_player__col_loop_cond

check_player__col_loop_end:
	b 			check_player__row_loop_step

check_player__row_loop_step:
	addi		$t0, $t0, 1
	b			check_player__row_loop_cond

check_player__row_loop_end:
	li			$v0, TRUE 													# return TRUE;
	b			check_player_win__epilogue

check_player__return_false:
	li			$v0, FALSE													# return FALSE;
	b			check_player_win__epilogue

check_player_win__epilogue:
	pop			$ra
	end
	jr			$ra		# return;


################################################################################
################################################################################
###                 PROVIDED FUNCTIONS — DO NOT CHANGE THESE                 ###
################################################################################
################################################################################


################################################################################
# .TEXT <print_board>
# YOU DO NOT NEED TO CHANGE THE PRINT_BOARD FUNCTION
.text
print_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$a0, $v0, $t0, $t1, $t2, $t3, $t4, $s0]
	# Clobbers: [$a0, $v0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - $s0: saved $a0
	#   - $t0: col, row
	#   - $t1: col
	#   - $t2: [row][col]
	#   - $t3: &board[row][col]
	#   - $t4: board[row][col]
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#   -> body
	#      -> for_header_init
	#      -> for_header_cond
	#      -> for_header_body
	#      -> for_header_step
	#      -> for_header_post
	#      -> for_row_init
	#      -> for_row_cond
	#      -> for_row_body
	#         -> for_col_init
	#         -> for_col_cond
	#         -> for_col_body
	#         -> for_col_step
	#         -> for_col_post
	#      -> for_row_step
	#      -> for_row_post
	#   -> [epilogue]

print_board__prologue:
	begin							# begin a new stack frame
	push		$ra						# | $ra
	push		$s0						# | $s0

print_board__body:
	move 		$s0, $a0

	li			$v0, 11						# syscall 11: print_char
	la			$a0, ' '					#
	syscall							# printf("%c", ' ');
	syscall							# printf("%c", ' ');

print_board__for_header_init:
	li			$t0, 0						# int col = 0;

print_board__for_header_cond:
	bge			$t0, BOARD_SIZE, print_board__for_header_post	# if (col >= BOARD_SIZE) goto print_board__for_header_post;

print_board__for_header_body:
	li			$v0, 1						# syscall 1: print_int
	move		$a0, $t0					#
	syscall							# printf("%d", col);

	li			$v0, 11						# syscall 11: print_char
	li			$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_header_step:
	addiu		$t0, 1						# col++;
	b			print_board__for_header_cond

print_board__for_header_post:
	li			$v0, 11						# syscall 11: print_char
	la			$a0, '\n'					#
	syscall							# printf("%c", '\n');

print_board__for_row_init:
	li			$t0, 0						# int row = 0;

print_board__for_row_cond:
	bge			$t0, BOARD_SIZE, print_board__for_row_post	# if (row >= BOARD_SIZE) goto print_board__for_row_post;

print_board__for_row_body:
	li			$v0, 1						# syscall 1: print_int
	move		$a0, $t0					#
	syscall							# printf("%d", row);

	li			$v0, 11						# syscall 11: print_char
	li			$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_col_init:
	li			$t1, 0						# int col = 0;

print_board__for_col_cond:
	bge			$t1, BOARD_SIZE, print_board__for_col_post	# if (col >= BOARD_SIZE) goto print_board__for_col_post;

print_board__for_col_body:
	mul			$t2, $t0, BOARD_SIZE				# &board[row][col] = (row * BOARD_SIZE
	add			$t2, $t2, $t1					#		      + col)
	mul			$t2, $t2, 1					# 		      * sizeof(char)
	add 		$t3, $s0, $t2					# 		      + &board[0][0]
	lb			$t4, ($t3)					# board[row][col]

	li			$v0, 11						# syscall 11: print_char
	move		$a0, $t4					#
	syscall							# printf("%c", board[row][col]);

	li			$v0, 11						# syscall 11: print_char
	li			$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_col_step:
	addi		$t1, $t1, 1					# col++;
	b			print_board__for_col_cond			# goto print_board__for_col_cond;

print_board__for_col_post:
	li			$v0, 11						# syscall 11: print_char
	li			$a0, '\n'					#
	syscall							# printf("%c", '\n');

print_board__for_row_step:
	addi		$t0, $t0, 1					# row++;
	b			print_board__for_row_cond			# goto print_board__for_row_cond;

print_board__for_row_post:
print_board__epilogue:
	pop			$s0						# | $s0
	pop			$ra						# | $ra
	end							# ends the current stack frame

	jr			$ra						# return;


################################################################################
# .TEXT <swap_turn>
.text
swap_turn:
	# Args:	    void
	#
	# Returns:  void
	#
	# Frame:    []
	# Uses:     [$t0]
	# Clobbers: [$t0]
	#
	# Locals:
	#
	# Structure:
	#   swap_turn
	#   -> body
	#      -> red
	#      -> blue
	#   -> [epilogue]

swap_turn__body:
	lb	$t0, whose_turn
	bne	$t0, BLUE, swap_turn__blue			# if (whose_turn != BLUE) goto swap_turn__blue;

swap_turn__red:
	li	$t0, RED					# whose_turn = RED;
	sb	$t0, whose_turn					# 
	
	j	swap_turn__epilogue				# return;

swap_turn__blue:
	li	$t0, BLUE					# whose_turn = BLUE;
	sb	$t0, whose_turn					# 

swap_turn__epilogue:
	jr	$ra						# return;

################################################################################
# .TEXT <get_end_row>
.text
get_end_row:
	# Args:
	#   - $a0: int  start_row
	#   - $a1: char direction
	#   - $a2: int  ship_len
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#
	# Structure:
	#   get_end_row
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

get_end_row__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra

get_end_row__body:
	move	$v0, $a0					
	beq		$a1, 'L', get_end_row__epilogue			# if (direction == 'L') return start_row;
	beq		$a1, 'R', get_end_row__epilogue			# if (direction == 'R') return start_row;

	sub		$t0, $a2, 1
	sub		$v0, $a0, $t0
	beq		$a1, 'U', get_end_row__epilogue			# if (direction == 'U') return start_row - (ship_len - 1);

	sub		$t0, $a2, 1
	add		$v0, $a0, $t0
	beq		$a1, 'D', get_end_row__epilogue			# if (direction == 'D') return start_row + (ship_len - 1);

	li		$v0, INVALID					# return INVALID;

get_end_row__epilogue:
	pop		$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;


################################################################################
# .TEXT <get_end_col>
.text
get_end_col:
	# Args:
	#   - $a0: int  start_col
	#   - $a1: char direction
	#   - $a2: int  ship_len
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#
	# Structure:
	#   get_end_col
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

get_end_col__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra

get_end_col__body:
	move	$v0, $a0					
	beq	$a1, 'U', get_end_col__epilogue			# if (direction == 'U') return start_col;
	beq	$a1, 'D', get_end_col__epilogue			# if (direction == 'D') return start_col;

	sub	$t0, $a2, 1
	sub	$v0, $a0, $t0
	beq	$a1, 'L', get_end_col__epilogue			# if (direction == 'L') return start_col - (ship_len - 1);

	sub	$t0, $a2, 1
	add	$v0, $a0, $t0
	beq	$a1, 'R', get_end_col__epilogue			# if (direction == 'R') return start_col + (ship_len - 1);

	li	$v0, INVALID					# return INVALID;

get_end_col__epilogue:
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;

print__at_address_word:

print__at_address_word_prologue:
	begin
	push		$ra
	push		$a0
print__at_address_word_body:
	lw			$t7, ($a0)
	move		$a0, $t7
	li			$v0, 1
	syscall

	li			$a0, '\n'
	li			$v0, 11
	syscall

print__at_address_word_epilogue:
	pop			$a0
	pop			$ra
	end

	jr			$ra