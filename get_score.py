#!/usr/bin/python3

#Author: Amir Mirzaei

import os
import sys

def calc_file_score(file: str):
    f = open(file, 'r')

    mod = 0
    team_count = 0
    scores = []
    for line in f:
        if len(line) > 1:
            if mod == 1:
                scores[team_count][1] = int(line)
                team_count += 1
            else:
                scores.append([line.rstrip(), 0])

            mod = (mod + 1) % 2     

    scores.sort(key= lambda score: score[1])

    result_score = [['', 0]] * team_count

    cache = -1 # used to cache index of last team with samce score in list

    for i in range(team_count):
        if i > cache:
            cache = i
            while cache + 1 < team_count and scores[i][1] == scores[cache + 1][1]:
                cache += 1
        
        result_score[i] = [scores[i][0], (cache + 1) / team_count * 100]

    return result_score


if len(sys.argv) > 1:
    input_path = sys.argv[1]
    if input_path[-1] !='/':
        input_path += '/'
    input_path += "out/"
else:
    input_path = "out/"

input_files = os.listdir(input_path)
number_of_inputs = len(input_files)

summed_scores = {}

for f in input_files:
    input_results = calc_file_score(input_path + f)
    
    for s in input_results:
        if s[0] not in summed_scores:
            summed_scores[s[0]] = s[1]
        else:
            summed_scores[s[0]] += s[1]

final_scores = []
for u, v in summed_scores.items():
    final_scores.append([u, v / number_of_inputs])

if len(sys.argv) > 2:
    out_file_name = sys.argv[2] + "_results.txt"
else:
    out_file_name = "results.txt"

out_file = open(out_file_name, 'w')

final_scores.sort(reverse= True, key= lambda entry: entry[1])

for entry in final_scores:
    out_file.write(entry[0] + "\n")
    out_file.write(str(entry[1]) + "\n")
    out_file.write("\n")