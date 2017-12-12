class Context(object):
    def __enter__(self):
        print 'entering the zone'

    def __exit__(self,exception_type,exception_value,exception_traceback):
        print 'leaving the zone'
        if exception_type is None:
            print 'with no error'
        else:
            print 'with an error:%s' % exception_value

with Context():
    print 'i am the zone'
