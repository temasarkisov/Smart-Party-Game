import json

def parseLine(line, fpOut):
    lineSplited = line.split("word='")

    lineSplitedSplited = lineSplited[1].split("' ")

    lineSplitedSplitedSplited = lineSplitedSplited[2].split("'")

    words.append(str(lineSplitedSplited[0].strip()))
    points.append(int(lineSplitedSplitedSplited[1].strip()))


    

words = []
points = []
matrix = []


filepath = 'cities_txt.txt'
fileOut = 'topic_cities.json'

fp = open(filepath)
fpOut = open(fileOut)

for line in fp:
    parseLine(line, fpOut)

for i in range(len(words)):
    words[i] = words[i].replace("\"", "") 
    matrix.append([words[i], points[i]])
    
#print(matrix)

with open(fileOut, 'w') as f:
    json.dump(matrix, f, sort_keys=False, indent=4, ensure_ascii=False)