# Music-Synthesizer

In this project, we would use IIT-Bombay's custom made Altera-V FPGA board.

I played the Rhythm:-

| Notes | Pa |Dha|Pa |Ma |Ga |Ma |Pa |Ma |Ga |Re |
| :---: | :---: |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Duration(s) | 1 |0.25|0.25|0.25|0.25|1|0.25|0.25|0.25|0.25|

| Notes | Ga |Ma|Ga |Re |Sa |Ni |Re |Sa |Sa |Silent |
| :---: | :---: |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Duration(s) | 1 |0.25|0.25|0.25|0.25|0.5|0.5|0.25|0.25|0.5|


Generated a CLK, which is of the Lesat count of the rhythm(0.25s) and played the same notes twice when the duration was 0.5s
The [Tone_generator](https://github.com/nirmalshah123/Music-Synthesizer/tree/main/Tone_generator) takes the note to be played as an input, and drives the speaker.

The [Music_synthesizer](https://github.com/nirmalshah123/Music-Synthesizer/tree/main/Music_Synthesizer) generates the rhythm and sends it to the Tone_generator to play the notes.

Here is the [demo](https://drive.google.com/file/d/1IMznkZa3Fjzp9FLKcvM7yD59XUAgje2S/view) of the video



https://user-images.githubusercontent.com/62292293/188073095-b6e532a7-f382-4a70-ad10-465029fe1cec.mp4

