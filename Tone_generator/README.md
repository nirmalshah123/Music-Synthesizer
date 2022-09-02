# Tone Generator

In this project, we would use IIT-Bombay's custom made Altera-V FPGA board.

We would generate a particular note/tone based on the slide switches present on the board, and a transistor to load the speaker

We have an on-board clock of 50Mhz. To generate a frequency "f" we will count the number of cycles and generate the neceesary CLK to drive the speaker.

| Note   |      Frequency(Hz)      |  Count value|
|:------:|:-----------------------:|:-----------:|
| Sa     |           240           |   104168    |
| Re     |           270           |    92593    |
| Ga     |           300           |    83333    |
|Ma      |           320           |    78125    |
|Pa      |           360           |    69444    |
|Dha     |           400           |    62500    |
|Ni      |           450           |    55555    |
|Sa(upper octave)|   480           |    52083    |

We have used 1-hot encoding scheme, to represent the states of the FSM.

