#!/usr/bin/env python3
from time import sleep
text_file = "trole.txt"

with open(text_file, 'r') as f:
    for line in [a.rstrip().split() for a in f.readlines()]:
        for word in line:
            for letter in word:
                print(letter)
                sleep(1/len(word))
            sleep(.5)
            print()
