fileName = input("File to convert: ")
fileIn = open(fileName + ".ppm")
fileOut = open(fileName + ".v", "w")

data = fileIn.read().split()
fileIn.close()

pixelCount = 0
currLine = "sprite["
for i in range(len(data)):
    if i >= 4:
        if (i-4) % 3 == 0:
            currLine += str(pixelCount) + "] = 12'b"
        currLine += format(int(data[i]), 'b').zfill(8)[-4:]
        if (i-4) % 3 == 2:
            currLine += ";\n"
            fileOut.write(currLine)
            pixelCount += 1
            currLine = "sprite["

fileOut.close()

