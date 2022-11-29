; .equ directives for aliases
.equ SEG_A,0x80
.equ SEG_B,0x40 
.equ SEG_C,0x20 
.equ SEG_D,0x08 
.equ SEG_E,0x04 
.equ SEG_F,0x02 
.equ SEG_G,0x01 
.equ SEG_P,0x10

.equ ONE, SEG_B|SEG_C
.equ TWO, SEG_A|SEG_B|SEG_F|SEG_E|SEG_D
.equ THREE, SEG_A|SEG_B|SEG_F|SEG_C|SEG_D
.equ FOUR, SEG_G|SEG_F|SEG_B|SEG_C
.equ FIVE, SEG_A|SEG_G|SEG_F|SEG_C|SEG_D
.equ SIX, SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C
.equ SEVEN, SEG_A|SEG_B|SEG_C
.equ EIGHT, SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G
.equ NINE, SEG_A|SEG_G|SEG_F|SEG_B|SEG_C
.equ ZERO, SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G
.equ ERROR, SEG_A|SEG_G|SEG_F|SEG_E|SEG_D

.equ PRINT_TO_LED, 0x200
.equ CHECK_BLACK, 0x202
.equ CHECK_BLUE, 0x203
.equ PRINT_TO_LCD, 0x205
.equ SWI_CLEAR_LCD, 0x206

.equ NUM_ZERO,  0x2000
.equ NUM_ONE,   0x0100
.equ NUM_TWO,   0x0200
.equ NUM_THREE, 0x0400
.equ NUM_FOUR,  0x0010
.equ NUM_FIVE,  0x0020
.equ NUM_SIX,   0x0040
.equ NUM_SEVEN, 0x0001
.equ NUM_EIGHT, 0x0002
.equ NUM_NINE,  0x0004
.equ NUM_NA,    0x0008|0x0080|0x0800|0x1000|0x4000|0x8000


InitLoop:
; Init Blank 8-segment display
mov r0,#0x00
swi PRINT_TO_LED

; Init decimal value 1024
swi SWI_CLEAR_LCD
mov r0,#15
mov r1,#10
mov r2,#24
swi PRINT_TO_LCD

ReadBlueLoop:
; Blue Button Num-pad Checks
swi CHECK_BLUE

cmp r0,#NUM_ONE
subeq r2,r2,#1
beq PrintONE

cmp r0,#NUM_TWO
subeq r2,r2,#2
beq PrintTWO

cmp r0,#NUM_THREE
subeq r2,r2,#3
beq PrintTHREE

cmp r0,#NUM_FOUR
subeq r2,r2,#4
beq PrintFOUR

cmp r0,#NUM_FIVE
subeq r2,r2,#5
beq PrintFIVE

cmp r0,#NUM_SIX
subeq r2,r2,#6
beq PrintSIX

cmp r0,#NUM_SEVEN
subeq r2,r2,#7
beq PrintSEVEN

cmp r0,#NUM_EIGHT
subeq r2,r2,#8
beq PrintEIGHT

cmp r0,#NUM_NINE
subeq r2,r2,#9
beq PrintNINE

cmp r0,#NUM_ZERO
beq PrintZERO

; Check for N/A Button Press
cmp r0,#0x0008
beq PrintERROR
cmp r0,#0x0080
beq PrintERROR
cmp r0,#0x0800
beq PrintERROR
cmp r0,#0x1000
beq PrintERROR
cmp r0,#0x4000
beq PrintERROR
cmp r0,#0x8000
beq PrintERROR

swi SWI_CLEAR_LCD
mov r0,#15
mov r1,#10
swi PRINT_TO_LCD


; Check Black Buttons for press
; If pressed reset system
swi CHECK_BLACK
cmp r0,#0x01
beq InitLoop
cmp r0,#0x02
beq InitLoop

;cmp r2,#0
;ble DecimalGone

b ReadBlueLoop

; Print to 8-Segment LED
PrintONE:
moveq r0,#ONE
swi PRINT_TO_LED
b ReadBlueLoop

PrintTWO:
moveq r0,#TWO
swi PRINT_TO_LED
b ReadBlueLoop

PrintTHREE:
moveq r0,#THREE
swi PRINT_TO_LED
b ReadBlueLoop

PrintFOUR:
moveq r0,#FOUR
swi PRINT_TO_LED
b ReadBlueLoop

PrintFIVE:
moveq r0,#FIVE
swi PRINT_TO_LED
b ReadBlueLoop

PrintSIX:
moveq r0,#SIX
swi PRINT_TO_LED
b ReadBlueLoop

PrintSEVEN:
mov r0,#SEVEN
swi PRINT_TO_LED
b ReadBlueLoop

PrintEIGHT:
mov r0,#EIGHT
swi PRINT_TO_LED
b ReadBlueLoop

PrintNINE:
mov r0,#NINE
swi PRINT_TO_LED
b ReadBlueLoop

PrintZERO:
mov r0,#ZERO
swi PRINT_TO_LED
b ReadBlueLoop

PrintERROR:
mov r0,#ERROR
swi PRINT_TO_LED
b ReadBlueLoop

;DecimalGone:
;mov r0,#0
;mov r1,#11
;ldr r2,=finishString0
;swi 0x204
;mov r0,#0
;mov r1,#12
;ldr r2,=finishString1
;swi 0x204



b ReadBlueLoop

.data
finishString0: .asciz "Decimal Value Reached 0 or Less"
finishString1: .asciz "Stopping Program"
