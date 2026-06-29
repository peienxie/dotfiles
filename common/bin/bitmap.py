#!/usr/bin/env python3

def encode_bitmap(bits):
    bitmap = [0x00] * 16
    for b in bits:
        index = (b-1) // 8
        offset = 0x80 >> ((b-1) % 8)
        bitmap[index] |= offset
    return bitmap[:] if bitmap[0] & 0x80 else bitmap[:8]


text = input("input field of bitmap: ")
text = text.replace(' ','')
if not text:
    exit(-1)

bits = [int(bit) for bit in text.split(',')]

bitmap = encode_bitmap(bits)
arr = []
for bit in bitmap:
    arr.append("0x%02X" % bit)

bitmap_str = "[" + ', '.join(arr) + "]"
print(bitmap_str)


