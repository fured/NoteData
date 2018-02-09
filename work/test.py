import threading
global asdfgh
asdfgh = []

def aa():
    asdfgh.append('asdsaf')

def bb():
    aa()
    print asdfgh

if __name__ == '__main__':
    t1 = threading.Thread(target=bb)
    t1.start()
