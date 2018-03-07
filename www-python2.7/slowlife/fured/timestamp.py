from datetime import datetime
from time import strftime,mktime
from django.db import models
#
# Custom field types in here.
#
class UnixTimestampField(models.DateTimeField):
    """UnixTimestampField: creates a DateTimeField that is represented on the
    database as a TIMESTAMP field rather than the usual DATETIME field.
    """
    #__metaclass__ = models.SubfieldBase

    def __init__(self, null=False, blank=False, **kwargs):
        super(UnixTimestampField, self).__init__(**kwargs)
        # default for TIMESTAMP is NOT NULL unlike most fields, so we have to
        # cheat a little:
        self.blank, self.isnull = blank, null
        self.null = True # To prevent the framework from shoving in "not null".
        
    def db_type(self):
        typ=['TIMESTAMP']
        # See above!
        if self.isnull:
            typ += ['NULL']
        if self.auto_created:
            typ += ['default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP']
        return ' '.join(typ)
    
    def to_python(self, value):
        return datetime.fromtimestamp(value)

    def get_prep_value(self, value):
        if value==None:
            return None
        return mktime(value.timetuple())

    def get_db_prep_value(self, value):
        if value==None:
            return None
        return value
