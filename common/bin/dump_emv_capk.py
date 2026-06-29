#!/usr/bin/env python3

from dataclasses import dataclass
from pathlib import Path
from functools import cmp_to_key
import sys

path = Path.cwd()

filename = sys.argv[1] if len(sys.argv) >= 2 else input("input filename: ")
input_file = path / filename
output_file = Path(input_file.stem + ".out")
if output_file.is_file():
    output_file.unlink()

def hexlify(data: bytes, indent: int = 1):
    """
    convert given data to c array like string
    """
    ret = []
    tabs = "\t" * indent
    for i, d in enumerate(data):
        if i % 16 == 0:
            ret.append("\n%s0x%02x" % (tabs, d))
        else:
            ret.append("0x%02x" % d)
    ret.append("\n")
    brackettabs = "\t" * (indent - 1)
    return "%s{%s%s}" % (brackettabs, ", ".join(ret), brackettabs)

SINGLE_ARRAY = 1
MULTIPLE_ARRAY = 2

@dataclass
class Table(object):
    name: str
    len_string: str
    arr_type: int
    datas: list

    def add_data(self, data: bytes):
        self.datas.append(data)

    def dump(self) -> str:
        ret = []
        for data in self.datas:
            ret.append(data.hex())
        return ''.join(ret)


@dataclass
class EmvTable(Table):
    def dump(self) -> str:
        ret = []
        for data in self.datas:
            # table_id = data[0:1]
            # sublen = data[1:3]
            # index = data[3]
            emvdata = data[4:]
            ret.append(','.join(["0x%02X" % (d) for d in emvdata]))
        return '\n'.join(ret)


@dataclass
class CapkTable(Table):
    def dump(self) -> str:
        keys = []
        for data in self.datas:
            # table_id = data[0:1]
            # sublen = data[1:3]
            # index = data[3]
            key_index = data[4]
            # keylen = data[5:7]
            capk_data = data[7:]
            if int(key_index) == 2:
                keys[-1] = keys[-1] + capk_data
            else:
                keys.append(capk_data)
        ret = []
        def compare_key(e1, e2):
            if int(e1[0]) == int(e2[0]):
                return int(e1[2]) - int(e2[2])
            return int(e1[0]) - int(e2[0])
        keys = sorted(keys, key=cmp_to_key(compare_key))
        for k in keys:
            data = len(k).to_bytes(2, 'little') + k
            ret.append(','.join(["0x%02X" % d for d in data]))
        return '\n'.join(ret)

def create_table_data(tables: dict, id: str, data: bytes):
    try:
        t = tables[id]
    except KeyError:
        print("unknown table id found: %s" % table_id)
        return
    t.datas.append(data)


def dump_tables(tables: dict):
    arr = []
    for _, v in tables.items():
        arr.append(v.dump())
        arr.append("\n\n")
    return "".join(arr)


tables = {
    "0f": EmvTable("EMVParameters", "", SINGLE_ARRAY, []),
    "10": CapkTable("CAPK", "", SINGLE_ARRAY,[]),
}

with open(input_file, "rb") as f:
    f.seek(0, 2)
    end = f.tell()
    f.seek(0)
    while f.tell() != end:
        len_data = f.read(2)
        l = int(len_data.hex())
        if l == 171:
            reserved = f.read(3)
            l -= 3
        else:
            reserved = b""

        content_data = f.read(l)

        table_data = len_data + reserved + content_data

        table_id = content_data[0:1].hex()
        create_table_data(tables, table_id, content_data)

with open(output_file, "a") as out:
    out.write(dump_tables(tables))


