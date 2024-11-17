import sys
from pathlib import Path
import os

for source in sys.argv[1:]:
    print(source)
    target = source.removesuffix(".template")
    with open(source) as f, open(target, 'w') as f2:
        for line in f.readlines():
            if line.startswith("> !!!execute "):
                cmd = line.split("> !!!execute ")[1]
                result = os.popen("stty cols 78; " + cmd).read()
                f2.write("> " + cmd)
                f2.write(result)
            else:
                f2.write(line)
