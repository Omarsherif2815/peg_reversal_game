1. Project Description
In this project, you are going to implement a simple single-player board game of flipping
the color of pieces. The game is played on a board in the shape of a ’+’ where the
middle position is (0,0) and all other positions on the board are relative to it. You can
see exactly how the positions of all the pegs on the board in the figure below.

![image](https://github.com/user-attachments/assets/7eda1255-44a8-47bc-9235-0c453ec1abf1)

When the game starts, All the pegs are black except one which will be white. The
position of the first white peg can be anywhere on the board. The player can then make
a move of flipping a black peg to make it a white one. This can be done if:
a) The peg itself is black (white pegs cannot be flipped).
b) There is at least one peg around it that is white.
When checking the pegs around some positions, we do not look at the diagonals. So, we
only look at the pegs in the 4 directions around it (up, down, left, right). The player
wins if they are able to flip all the pegs on the board to white.
Your implementation for the game should have functions that create the initial state of
the board, output the possible states reachable from a ce
