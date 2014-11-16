sub-resync
==========

Simple script for editing timings in .SRT files at multiple points in the file (to account for differences in intro placement, commercial breaks etc). It will attempt to find these points automatically.

###Usage
* Just run the file in a directory containing an SRT file you want to edit
* Follow the instructions, providing the names of input and output files (which can't be the same)

###Requirements
* Ruby 1.87+
* If you find any bugs or issues feel free to contact me or open an Issue here on Github.

###Notes
* You must enter timings in the form HH:MM:SS,mmm or you'll get an error.
* If you edit the timings once, doing so again will use the updated timings, not the original ones.
* The program saves the milisecond values and then sticks them back on at the end, so it's not aware of these values during the actual retiming
