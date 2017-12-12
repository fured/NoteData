class A(object):
    def __init__(self):
        print 'A'
        super(A,self).__init__()

class B(object):
    def __init__(self):
        print 'B'
        super(B,self).__init__()

class D(object):
    def __init__(self):
        print 'D'
        super(D,self).__init__()

class C(A,B):
    def __init__(self):
        print 'C'
        A.__init__(self)
        B.__init__(self)

class E(A,B,D):
    def __init__(self):
        print "E"
        A.__init__(self)
        B.__init__(self)
        D.__init__(self)

print "MRO:",[x.__name__ for x in C.__mro__] 
C()
print "MRO:",[x.__name__ for x in A.__mro__]
A()
print "MRO:",[x.__name__ for x in B.__mro__]
B()
print "MRO:",[x.__name__ for x in E.__mro__]
E()
