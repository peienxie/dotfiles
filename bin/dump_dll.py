#!/usr/bin/env python3

from dataclasses import dataclass
from pathlib import Path
import sys

path = Path.cwd()

filename = sys.argv[1] if len(sys.argv) >= 2 else input("input filename: ")
input_file = path / filename
output_file = path / "out.txt"
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
        if len(self.datas) == 0:
            return ""

        if self.arr_type == SINGLE_ARRAY:
            arr = []
            for d in self.datas:
                arr.append(hexlify(d, indent=2))
            s = ",\n".join(arr) + ","
            return "const UCHAR %s[][%s] = {\n%s\n};" % (self.name, self.len_string, s)
        elif self.arr_type == MULTIPLE_ARRAY:
            cnt = 1
            arr = []
            var_names = []
            lens = []
            for d in self.datas:
                s = hexlify(d)
                var_name = "%s_%02d" % (self.name, cnt)
                var_names.append(var_name)
                arr.append("const UCHAR %s[] = %s;\n" % (var_name, s))
                lens.append("LEN(%s)" % (var_name))
                cnt += 1
            all_data = "".join(arr)
            all_data_define = "#define %s %s" % (self.name.upper() + "_ALL", ",".join(var_names))
            lens = "int %sLens[] = {%s};" % (self.name, ", ".join(lens))
            return "\n".join([all_data, all_data_define, lens])
        return ""


def create_table_data(tables: dict, id: str, data: bytes):
    try:
        t = tables[id]
    except KeyError:
        print("unknown table id found: %s", table_id)
        return
    t.datas.append(data)


def dump_tables(tables: dict):
    arr = []
    for _, v in tables.items():
        arr.append(v.dump())
        arr.append("\n\n")
    return "".join(arr)


tables = {
    "01": Table("TerminalInfoTable", "TERMINFO_TABLE_LEN", SINGLE_ARRAY, []),
    "02": Table("CardRangeTable", "CARDRANGE_TABLE_LEN", SINGLE_ARRAY, []),
    "03": Table("IssuerTable", "ISSUER_TABLE_LEN", SINGLE_ARRAY, []),
    "04": Table("AcquirerTable", "ACQUIRER_TABLE_LEN", SINGLE_ARRAY, []),
    "0f": Table("EMVParameters", "VARLEN", MULTIPLE_ARRAY, []),
    "10": Table("CAPK", "", MULTIPLE_ARRAY,[]),
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
        create_table_data(tables, table_id, table_data)

with open(output_file, "a") as out:
    out.write(dump_tables(tables))

