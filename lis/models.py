# This is an auto-generated Django model module.

from django.db import models

class Course(models.Model):
    course_id = models.AutoField(primary_key=True)
    academic_field = models.CharField(max_length=20, blank=True)
    academic_course_number = models.CharField(max_length=10, blank=True)
    instructor = models.CharField(max_length=40, blank=True) 
    course_location = models.CharField(max_length=20, blank=True)
    academic_location = models.CharField(max_length=20, blank=True)
    academic_term = models.CharField(max_length=20, blank=True)
    snapshot_date = models.DateField(null=True, blank=True)
    students = models.ManyToManyField("Student", blank=True)
    def __unicode__(self):
        return u'%s %s' % (self.academic_field, self.academic_course_number)
    class Meta:
        db_table = u'lis_courses'

class Librarian(models.Model):
    librarian_id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    def __unicode__(self):
        return u'%s %s' % (self.first_name, self.last_name)
    class Meta:
        db_table = u'lis_librarians'

class SessionType(models.Model):
    session_type_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    def __unicode__(self):
        return u'%s' % (self.name)
    class Meta:
        db_table = u'lis_session_types'

class Session(models.Model):
    session_id = models.AutoField(primary_key=True)
    date = models.DateField(null=True, blank=True)
    librarian = models.ForeignKey(Librarian)
    session_type = models.ForeignKey(SessionType)
    location = models.CharField(max_length=40, blank=True)
    gov_docs = models.BooleanField(blank=True)
    session_format = models.ForeignKey("SessionFormat", null=True)
    course = models.ForeignKey(Course)
    def __unicode__(self):
        return u'%s - %s' % (self.date, self.session_type)
    class Meta:
        db_table = u'lis_sessions'

class SessionFormat(models.Model):
    session_format_id = models.AutoField(primary_key=True)
    format_name = models.CharField(max_length=40)
    def __unicode__(self):
        return u'%s' % (self.format_name)
    class Meta:
        db_table = u'lis_session_formats'

class Student(models.Model):
    student_id = models.AutoField(primary_key=True)
    last_name = models.CharField(null=True, max_length=40, blank=True)
    first_name = models.CharField(null=True, max_length=40, blank=True)
    wsu_id = models.IntegerField(unique=True)
    network_id = models.CharField(max_length=40, blank=True)
    def __unicode__(self):        
        if self.first_name and self.last_name:            
            return u'%s %s' % (self.first_name, self.last_name)
        else:
            return u'%d' % (self.wsu_id)
    class Meta:
        db_table = u'lis_students'

class StudentSnapshot(models.Model):
    student_snapshot_id = models.AutoField(primary_key=True)
    student = models.ForeignKey(Student)
    academic_degree_major = models.CharField(max_length=40, blank=True)
    cumulative_gpa = models.DecimalField(max_digits=3, decimal_places=2)
    email = models.CharField(max_length=80, blank=True)
    phone_1 = models.CharField(max_length=20, blank=True)
    phone_2 = models.CharField(max_length=20, blank=True)
    snapshot_date = models.DateField(null=True, blank=True)
    address_street_1 = models.CharField(max_length=80, blank=True)
    address_street_2 = models.CharField(max_length=80, blank=True)
    address_city = models.CharField(max_length=40, blank=True)
    address_state = models.CharField(max_length=20, blank=True)
    address_zip = models.CharField(max_length=10, blank=True)
    address_business_act_code = models.CharField(max_length=10, blank=True)
    class Meta:
        db_table = u'lis_student_snapshots'




