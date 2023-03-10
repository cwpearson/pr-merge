import os
import csv
import math
from operator import itemgetter
import sys

kinds = {}

for filename in os.listdir(os.getcwd()):

    begin = filename.find("new-spmv-kind_")
    end = filename.find('.o')

    if begin != -1 and end != -1:
        kind = filename[14:end]
        if kind not in kinds:
            kinds[kind] = set()
        kinds[kind].add(filename)

    begin = filename.find("rocsparse-spmv-kind_")
    end = filename.find('.o')

    if begin != -1 and end != -1:
        kind = filename[20:end]
        
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
            for _ in range(10): # skip first 10 rows
                next(reader)
            for row in reader:

                # skip the last row
                if len(row) < 4:
                    continue

                if row[8] != "": # error occured
                    continue


                # print(row)
                benchmark = row[0]

                mat = benchmark[13:13+benchmark[13:].find("/")]

                real_time = row[2]
                nnz = row[-2]
                num_rows = row[-1]
                
                if mat not in mats:
                    mats[mat] = {}

                if "rocsparse-spmv" in file:
                    mats[mat]["rocsparse"] = float(real_time)
                elif "new-spmv" in file:
                    mats[mat]["merge"] = float(real_time)
                elif "kk-spmv" in file:
                    mats[mat]["native"] = float(real_time)

    # print(mats)

    merge_vs_rocsparse_geom = 1
    merge_vs_native_geom = 1
    for mat,times in mats.items():

        skip = False
        if "native" not in times:
            print(f"couldn't find native result for {mat}", file=sys.stderr)
            skip = True
        if "rocsparse" not in times:
            print(f"couldn't find rocsparse result for {mat}", file=sys.stderr)
            skip = True
        if "merge" not in times:
            print(f"couldn't find merge result for {mat}", file=sys.stderr)
            skip = True
        if skip:
            continue

        merge_vs_rocsparse_geom *= math.pow(times["rocsparse"] / times["merge"], 1.0/len(mats))
        merge_vs_native_geom *= math.pow(times["native"] / times["merge"], 1.0/len(mats))

    results += [(kind, len(mats), merge_vs_rocsparse_geom, merge_vs_native_geom)]


results = sorted(results)
by_native = sorted(results, key=itemgetter(3), reverse=True)

print("| SuiteSparse Kind | No. of Mats | Geomean vs Native | Geomean vs rocSparse |")
print("|------------------|-------------|-------------------|----------------------|")
for row in by_native:
    print("|", row[0], "|", row[1], "|", f"{row[3]:.2f}", "|", f"{row[2]:.2f}", "|")


