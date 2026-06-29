#!/usr/bin/env python3
import sys

text = sys.argv[1] if len(sys.argv) >= 2 else input("Input chinese text: ")
if text == "":
    exit(1)

try:
    big5_bytes = text.encode("big5")
except UnicodeEncodeError:
    print("encode big5 error!!!")
    exit(2)

def format(s):
    arr = []
    for b in s:
        arr.append("0x%02X" % b)
    data = ",".join(arr)
    return "{" + data + "};"

print(format(big5_bytes))
