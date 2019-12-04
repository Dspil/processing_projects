import sys

def countlines(a):
    f = open(a, 'r')
    c = 0;
    flag = True;
    for line in f:
        if line != '\n' and line[0] != '/' and flag:
            c+=1
        if line[:2] == '/*':
            flag = False
        if line[:2] == '*/':
            flag = True
    f.close()
    return c

project = "c:\\users\\denni_000\\desktop\\Programs\\c\\NeuronProgram\\neurons2bisection\\"
c = 0
for i in range(1, len(sys.argv)):
    c += countlines(sys.argv[i])
print "\nNumber of lines = " + str(c) + "\n"
raw_input("Press Enter to exit")
