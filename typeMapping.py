types = {"five_bool_two_double_struct_t": "VCUStatus",
         "uint8_struct_t": "UINT32", "bool_struct_t": "Bool", "float_struct_t": "Float"}

f = open("MessageIDs.csv", "r")
print("static const QMap<quint16, DataType> idToType = {")
for line in f:
    line = line.split(",")
    print("{", line[1], ", DataType::" + str(types.get(line[4])), "}")
print("};")
f.close()
