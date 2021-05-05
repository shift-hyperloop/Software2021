#!/usr/bin/python

import sys
import re

data_types = {
            'c': 'uint8_t',
            'd': 'double',
            'i': 'uint32_t',
            's': 'uint16_t',
            'f': 'float',
            'b': 'bool'
            }

if (len(sys.argv) < 1):
    printf("Need at least one struct name")
    exit(-1)

for i in range(1, len(sys.argv)):
    print()
    struct = str(sys.argv[i])
    print('struct ' +  struct + ' : public DataStruct\n{')
    struct_name = struct
    struct = struct.replace('Vector', '')
    members = re.split(r'([\d]+.)', struct)
    members = [x for x in members if x]
    count = 0
    for member in members:
        num = re.search(r'\d+', member).group()
        member = member.replace(num, '')
        for _ in range(int(num)):
            print('\t' + data_types[member] + ' value_' + str(count) + ';')
            count += 1

    print('\n\tfriend QDataStream& operator<<(QDataStream& dataStream, const ' + struct_name + '& object)\n\t{')
    print('\t\tdataStream <<', end='')
    first = True
    count = 0
    for member in members:
        num = re.search(r'\d+', member).group()
        member = member.replace(num, '')
        for _ in range(int(num)):
            if first:
                print(' object.value_0', end='')
                first = False
                count += 1
                continue
            print('\n\t\t\t   << object.value_' + str(count), end='')
            count += 1
    print(';\n\n\t\treturn dataStream;\n\t}\n')

    print('\n\tfriend QDataStream& operator>>(QDataStream& dataStream, ' + struct_name + '& object)\n\t{')
    print('\t\tdataStream >>', end='')
    first = True
    count = 0
    for member in members:
        num = re.search(r'\d+', member).group()
        member = member.replace(num, '')
        for _ in range(int(num)):
            if first:
                print(' object.value_0', end='')
                first = False
                count += 1
                continue
            print('\n\t\t\t   >> object.value_' + str(count), end='')
            count += 1
    print(';\n\n\t\treturn dataStream;\n\t}\n')
    print('};')