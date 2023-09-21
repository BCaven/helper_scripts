#!/usr/bin/env python3

import requests, re
URL = "https://docs.python.org/3/library/re.html" #"https://www3.nd.edu/~pbui/teaching/cse.20289.sp23/"

def usage(code):
    print("""Usage: scrape [FLAGS] [SITE]
    if no URL is given, program assumes 'https://www3.nd.edu/~pbui/teaching/cse.20289.sp23/'
    FLAGS:
    -h          : help
    -p [PAGE]   : go to a specific page
    -s [REGEX]  : search for given pattern
    -t          : only scrape text
    """)
    exit(code)

def get_site(URL):
    return requests.get(URL).text

def clean(text):
    # remove the html tags and leave only the text
    for line in text.splitlines():
        print(line)

def apply_regex(text, regex):
    return re.findall(regex, text)

def main():
    # parse flags

    clean(get_site(URL))

if __name__ == "__main__":
    main()
