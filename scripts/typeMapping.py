types = {"five_bool_two_double_struct_t": "VCUStatus", "one_float_struct_t": "Float",
         "one_bool_struct_t": "Bool", "three_uint8_struct_t": "Vector3c", "vector_3f_psa_t": "Vector3f", "orientation_t": "Vector3f", "Vector_2f_t": "Vector2f", "one_uint8_struct_t": "Char"}

f = open("MessageIDs.csv", "r")
print("static const QMap<quint16, DataType> idToType = {")
for line in f:
    line = line.split(",")
    print("{", line[1], ", DataType::" + str(types.get(line[4])), "}")
print("};")
f.close()
