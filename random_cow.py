#!/usr/bin/env python3

import random
import os
import sys

def main():
    cows = []
    for index, line in enumerate(os.popen('cowsay -l')):
        if not index:
            continue
        line = line.strip()
        for cow in line.split():
            cows.append(cow)
    chosen = random.choice(cows)
    arguments = ' '.join(sys.argv[1:])
    if (arguments == ""):
        print("please add a string to say")
        return
    os.system(f'cowsay -f {chosen} {arguments}')

if __name__ == '__main__':
    main()
    
