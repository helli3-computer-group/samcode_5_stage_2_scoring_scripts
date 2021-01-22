#!/usr/bin/python3

#Author: Amir Mirzaei

import sys

if len(sys.argv) > 1:
    input_path = sys.argv[1]
    if input_path[-1] != '/':
        input_path += '/'
else:
    input_path = './'

if len(sys.argv) > 2:
    out_file_name = sys.argv[2] + "_total_sum.txt"
else:
    out_file_name = "total_sum.txt"

###############################################################################

f = open(input_path + "p1_results.txt", "r")

mod = 0
scores = {}
for line in f:
    if len(line) > 1:
        if mod == 1:
            scores[team_name] = float(line)
        else:
            team_name = line.rstrip()

        mod = (mod + 1) % 2     

###############################################################################

f = open(input_path + "p2_results.txt", "r")

mod = 0
for line in f:
    if len(line) > 1:
        if mod == 1:
            if team_name not in scores:
                scores[team_name] = float(line)
            else:
                scores[team_name] += float(line)
        else:
            team_name = line.rstrip()

        mod = (mod + 1) % 2 

###############################################################################

f = open(input_path + "p3_results.txt", "r")

mod = 0
for line in f:
    if len(line) > 1:
        if mod == 1:
            if team_name not in scores:
                scores[team_name] = float(line)
            else:
                scores[team_name] += float(line)
        else:
            team_name = line.rstrip()

        mod = (mod + 1) % 2 

###############################################################################

results = []
for u, v in scores.items():
    results.append([u, v])

out_file = open(out_file_name, 'w')

results.sort(reverse= True, key= lambda entry: entry[1])

for entry in results:
    out_file.write(entry[0] + "\n")
    out_file.write(str(entry[1]) + "\n")
    out_file.write("\n")
