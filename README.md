# arm-project-3

Using the ARMSim# + Embest plugin produce a program that behaves in the following manner:

The Keypad is assumed to function like so:

   7  	 8   	   9    N/A 
   4	   5   	   6	  N/A
   1	   2   	   3	  N/A
  N/A    0  	  N/A 	N/A

The 8 segment display should:
be blank on startup or when the system is reset.
display the value of the last blue key pressed.
display "E" if one of the unassigned buttons is pressed.

The LCD should:
display the decimal value 1024 on startup.

display the updated decimal value after a blue button is pressed based on the specifications below.

Pressing either of the black buttons should reset the system to the startup state as defined above.

Pressing any of the blue buttons should subtract the value from the current value on the LCD and update the displayed value.

The program should stop updating either display when the value gets to 0 or less until a reset occurs.

You can assume that the user will never press more than one key or button at a time.
