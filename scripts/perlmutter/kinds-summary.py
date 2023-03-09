import os
import csv
import math
from operator import itemgetter

kinds = {}

for filename in os.listdir(os.getcwd()):

    begin = filename.find("new-spmv-kind_")
    end = filename.find('.o')

    if begin != -1 and end != -1:
        kind = filename[14:end]
        
        if kind not in kinds:
            kinds[kind] = set()
        kinds[kind].add(filename)

    begin = filename.find("cusparse-spmv-kind_")
    end = filename.find('.o')

    if begin != -1 and end != -1:
        kind = filename[19:end]
        
        if kind not in kinds:
            kinds[kind] = set()
        kinds[kind].add(filename)

    begin = filename.find("kk-spmv-kind_")
    end = filename.find('.o')

    if begin != -1 and end != -1:
        kind = filename[13:end]
        
        if kind not in kinds:
            kinds[kind] = set()
        kinds[kind].add(filename)


results = []
for kind,files in kinds.items():

    # if "computational_fluid_dynamics" != kind:
    #     continue

    mats = {}

    for file in files:
        with open(file, 'r') as f:
            reader = csv.reader(f)
            for _ in range(12):
                next(reader)
            for row in reader:
                # skip the last row
                if len(row) < 8:
                    continue
                # print(row)
                benchmark = row[0]

                mat = benchmark[13:13+benchmark[13:].find("/")]

                real_time = row[2]
                nnz = row[-2]
                num_rows = row[-1]
                
                if mat not in mats:
                    mats[mat] = {}

                if "cusparse-spmv" in file:
                    mats[mat]["cusparse"] = float(real_time)
                elif "new-spmv" in file:
                    mats[mat]["merge"] = float(real_time)
                elif "kk-spmv" in file:
                    mats[mat]["native"] = float(real_time)

    # print(mats)

    merge_vs_cusparse_geom = 1
    merge_vs_native_geom = 1
    for mat,times in mats.items():
        merge_vs_cusparse_geom *= math.pow(times["cusparse"] / times["merge"], 1.0/len(mats))
        merge_vs_native_geom *= math.pow(times["native"] / times["merge"], 1.0/len(mats))

    results += [(kind, len(mats), merge_vs_cusparse_geom, merge_vs_native_geom)]


results = sorted(results)
by_native = sorted(results, key=itemgetter(3), reverse=True)

print("| SuiteSparse Kind | No. of Mats | Geomean vs Native | Geomean vs cuSparse |")
print("|------------------|-------------|-------------------|---------------------|")
for row in by_native:
    print("|", row[0], "|", row[1], "|", f"{row[3]:.2f}", "|", f"{row[2]:.2f}", "|")


