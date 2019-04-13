#!/usr/bin/python
import sys # inbuilt module, here we use to take input from the console     
for line in sys.stdin: # start a for loop, this is
# an infinite loop which runs as long as there is input, 
#sys.stdin will take input from the console
    line = line.strip() #.strip() function will remove the leading and trailing spaces, if any.
    keys = line.split(',') # .split() function will split the input based on the string passed as argument,
    value = 1 
#	if nothing is passed as an argument, space is taken as default
#initiating another for loop to print the words and 1
    print('{0}-{1}\t{2}'.format(keys[1], keys[7], value)) 
# this will print the word and 1 separated by tab to the console, which the reduces reads as input.


