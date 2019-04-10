# Blow to Start

Blow to Start is a single-player arcade game that was described entirely through Hardware (no 'programming' involved).\
It was built in 3 weeks for a culmulative project by Maduvan Kasi, Daniel Wang, and Anthony Alaimo.

### Instructions

The player controls a baloon in the vertical center of the screen. Once per frame, the balloon polls for input 
from the microphone, and moves either up or down depending on if it detected air or not. The balloon is able to loop 
past the top of the screen back up from the bottom, and vice versa. There are 2 missiles positioned on horizontal paths 
equidistant from the middle that travel in opposite directions. These missiles also loop past one side of the screen 
and reappear on the other side - they change to a random speed whenever they reappear. If the balloon comes into contact with 
either missile, the player loses and must restart. There is no win condition, aside from seeing how long you can survive.

### Experimental Mode

This is a special mode that can be toggled on or off at any point. When activated, the missiles gain vertical momentum, 
meaning they will travel diagonally. Similar to horizontal speed, their vertical trajectory is chosen at random everytime 
they reappear on screen. When turned off, the missiles lose all vertical momentum, but retain their current horizontal paths.

### Controls

Microphone: takes in digital input to move the balloon\
KEY[0]: restarts the game\
KEY[2]: alternate input for the microphone\
SW[0]: toggles between inputs (microphone/key[2])\
SW[1]: toggle between experimental mode (on/off)\
SW[2-17]: seeds the random value on restart\
