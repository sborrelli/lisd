### This is an auto-generated Django model module.
##/*
##* Copyright (c) 2012 Dario Alvarez Miranda, Steve Borrelli
##*
##* Permission is hereby granted, free of charge, to any person obtaining a copy of this
##* software and associated documentation files (the "Software"), to deal in the Software
##* without restriction, including without limitation the rights to use, copy, modify, 
##* merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
##* permit persons to whom the Software is furnished to do so, subject to the following conditions:
##* 
##* 
##* The above copyright notice and this permission notice shall be included in all copies or 
##* substantial portions of the Software.
##* 
##* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
##* BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
##* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
##* DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
##* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##*/

from django.db import models
import datetime
from django.db.models.signals import post_save

## Auxiliary methods used in models.py ##

def typedefault():
    t = SessionType.objects.filter(name='Course Related Instruction')
    if t:
        return t[0].session_type_id
    return

def formatdefault():
    f = SessionFormat.objects.filter(format_name='In Person')
    if f:
        return f[0].session_format_id
    return

def campusdefault():
    loc = Location.objects.filter(name__contains='Pullman')
    if loc:
        return loc[0].location_id
    return

def termdefault():
    term = ""
    today = datetime.date.today()
    SPRING_START = datetime.date(today.year, 1, 1)
    SPRING_END = datetime.date(today.year, 5, 10)
    SUMMER_START = datetime.date(today.year, 5, 11)
    SUMMER_END = datetime.date(today.year, 8, 20)
    FALL_START = datetime.date(today.year, 8, 21)
    FALL_END = datetime.date(today.year, 12, 31)    
    term = str(today.year)
    if SPRING_START <= today <= SPRING_END:
        term = "Spring " + term
    elif SUMMER_START <= today <= SUMMER_END:
        term = "Summer " + term
    elif FALL_START <= today <= FALL_END:
        term = "Fall " + term
    return term


## Data models ##

##class AcademicField(models.Model):
##    abbreviation = models.CharField(max_length=20,
##                    help_text='''Please use official departmental abbreviations <br>
##                    (e.g. English = ENGL, Chemistry = CHEM).<br>See schedule of
##                    classes for official abbreviations''')
##    name = models.CharField(max_length=200)
##    class Meta:
##        db_table = u'lis_academic_fields'
##    def __unicode__(self):
##        return u'%s - %s' % (self.abbreviation, self.name)

class Course(models.Model):
    course_id = models.AutoField(primary_key=True)
    #academic_field = models.ForeignKey(AcademicField)
    academic_field = models.CharField(max_length=20,
                    help_text='''Please use official departmental abbreviations <br>
                    (e.g. English = ENGL, Chemistry = CHEM).<br>See schedule of
                    classes for official abbreviations''')
    academic_course_number = models.CharField(max_length=10)
    description = models.CharField(null=True, blank=True, max_length=200,
                    help_text='''Official course title (e.g. <em>Introductory Writing</em> for English 101)''')    
    academic_location = models.ForeignKey("Location", null=True, blank=True)    
    def full_name(self):
        return u'%s %s - %s' % (self.academic_field,
                                self.academic_course_number,
                                self.academic_location)
    def __unicode__(self):
        return self.full_name()
    class Meta:
        db_table = u'lis_courses'
        ordering=['academic_field', 'academic_course_number']

class Location(models.Model):
    location_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    description = models.CharField(max_length=200, null=True, blank=True)
    def __unicode__(self):
        return u'%s' % (self.name)
    class Meta:
        db_table = u'lis_locations'
    

class Librarian(models.Model):
    librarian_id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    def __unicode__(self):
        return u'%s %s' % (self.first_name, self.last_name)
    class Meta:
        db_table = u'lis_librarians'
        ordering=['last_name']

class SessionType(models.Model):
    session_type_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    def __unicode__(self):
        return u'%s' % (self.name)
    class Meta:
        db_table = u'lis_session_types'

class Session(models.Model):
    session_id = models.AutoField(primary_key=True)
    date = models.DateField(null=True, blank=True,
            help_text="Please use the following format: <em>YYYY-MM-DD</em>.")
    librarian = models.ForeignKey(Librarian,
                                  related_name='sessions_mainlibrarian',
                                  help_text="Use for sessions with one librarian.<br>Otherwise, select <em>Multiple</em> and specify below.")
    librarians = models.ManyToManyField(Librarian, blank=True,
                                        help_text="Use for multiple librarians.<br>",
                                        verbose_name="Multiple Librarians")    
    session_type = models.ForeignKey(SessionType, default=typedefault)
    
    description = models.CharField(null=True, blank=True, max_length=200,
                    help_text="E.g. Zotero, Cougar Kids, etc.")
    number_of_users = models.IntegerField(null=True, blank=True,
                        help_text="Optional. Enter only if known.")
    location = models.CharField(max_length=40, blank=True, null=True)
    gov_docs = models.BooleanField('Government Docs',blank=True)
    session_format = models.ForeignKey("SessionFormat", null=True, default=formatdefault)
    #course information
    campus = models.ForeignKey("Location", null=True, blank=True, default=campusdefault)
    course = models.ForeignKey(Course, null=True, blank=True)
    SECTIONS = tuple ( [ (str(i),str(i)) for i in range(1,81) ] )
    section = models.CharField(max_length=20, null=True, blank=True,
                               choices=SECTIONS)
    academic_term = models.CharField(max_length=20, blank=True,
                    help_text='''Enter term and year e.g. Fall 2012.<br>
                    Leave blank for automatic calculation based on
                    the session date.''')
    instructor = models.CharField("Course Instructor", max_length=40, blank=True, null=True,
                        help_text="<em>Last, First</em> if known, otherwise just last name")
    students = models.ManyToManyField("Student", blank=True,
                                      db_table=u'lis_sessions_students')
    #student_ids = models.CharField(max_length=4000, null=True)
    def __unicode__(self):
        if self.description.strip():
            return u'%s - %s by %s' % (self.date, self.description, self.librarian)
        else:
            return u'%s - %s by %s' % (self.date, self.session_type, self.librarian)
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
    wsu_id = models.IntegerField("WSU ID", unique=True)
    network_id = models.CharField(max_length=40, blank=True)
    sessions = models.ManyToManyField(Session, blank=True,
                                      db_table=Session.students.field.db_table,)
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
