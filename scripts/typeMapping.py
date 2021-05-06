import csv
import sys

types = {"five_bool_two_double_struct_t": "VCU_STATUS", 
         "one_float_struct_t": "FLOAT",
         "one_float": "FLOAT",
         "one_bool_struct_t": "BOOL", 
         "three_uint8_struct_t": "VECTOR_3C", 
         "vector_3f_psa_t": "VECTOR_3F", 
         "orientation_t": "VECTOR_3F", 
         "Vector_2f_t": "VECTOR_2F", 
         "one_uint8_struct_t": "CHAR",
         "30_uint16_t": "VECTOR_30S",
         "23_uint16_t": "VECTOR_23S",
         "error_struct_t": "ERROR_CODE",
         "vector_3f_t": "VECTOR_3F",
         "bms_status_t": "BMS_STATUS",
         "bms_safety_t": "BMS_SAFETY"
         }

if len(sys.argv) == 1:
    filepath = 'MessageIDs.csv'  
else:
     filepath = sys.argv[1]

print("static const QMap<quint16, DataType> idToType = {")

with open(filepath, 'r') as f:
    reader = csv.reader(f)
    for row in reader:
        if not types.get(row[5]):
            continue
        print("  {", '0x' + row[3], ", DataType::" + str(types.get(row[5])), "},")
    print("}\n")
    print('static const QMap<quint16, QString> idToName = {')

with open(filepath, 'r') as f:  
    read = csv.reader(f)
    for row in read:
        if not types.get(row[5]):
            continue
        print("  {", '0x' + row[3], ", \"" + row[4] + "\" },")
    print("}")
    #for line in f:
    #    line = line.split(",")
    #    print("{", line[1], ", DataType::" + str(types.get(line[4])), "}")
    #print("};")
    #f.close()
