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
from lis.models import *
from django.contrib import admin
from django.forms import TextInput
from lis.forms import SessionAdminForm
from django.db.models import Sum, Q
import datetime

class CourseAdmin(admin.ModelAdmin):
    fields = ['academic_field', 'academic_course_number', 'description', 'academic_location']

    list_display = ('full_name',)

admin.site.register(Course, CourseAdmin)

def calculate_term(date):
    '''Calculates the academic term based on a date'''
    term = ""
    #today = datetime.date.today()
    SPRING_START = datetime.date(date.year, 1, 1)
    SPRING_END = datetime.date(date.year, 5, 10)
    SUMMER_START = datetime.date(date.year, 5, 11)
    SUMMER_END = datetime.date(date.year, 8, 20)
    FALL_START = datetime.date(date.year, 8, 21)
    FALL_END = datetime.date(date.year, 12, 31)    
    term = str(date.year)
    if SPRING_START <= date <= SPRING_END:
        term = "Spring " + term
    elif SUMMER_START <= date <= SUMMER_END:
        term = "Summer " + term
    elif FALL_START <= date <= FALL_END:
        term = "Fall " + term
    return term

class SessionAdmin(admin.ModelAdmin):
    form = SessionAdminForm
    fieldsets = [
        (None,                  {'fields': [('session_format', 'campus'), ('date', 'academic_term'), ('session_type',
                                            'description'), ('librarian', 'number_of_users', 'gov_docs'), ('course', 'section', 'instructor')],
                                 'description': 'Fields in <b>boldface</b> are required.<br>'}),
        ('Multiple Librarians',            {'fields': ['librarians'], 'classes': ['collapse']}),
        ('Students',            {'fields': [('students_list','clear_existing'),'students'], 'classes': ['collapse']})
    ]    

    list_display = ('date', 'session_type', 'description',
                    'number_of_users','librarian', 'course', 'enrolled_students')

    list_filter = ['date', 'session_type', 'librarian']

    filter_horizontal = ('librarians','students')

    readonly_fields = ('students',)

    def save_model(self, request, obj, form, change):        
        if form.is_valid() and form.cleaned_data['clear_existing']:            
            obj.students.clear()
        #studs = form.cleaned_data['students']
        #studs.clear()
        if not len(obj.academic_term) > 0:
            obj.academic_term = calculate_term(obj.date)        
        obj.save()        
        #if there is a students file upload, process it        
        csv_file = request.FILES.get('students_list',None)        
        if csv_file:
            #form.add_students(obj, csv_file)
            import_students(obj, csv_file)

    def enrolled_students(self, obj):
        return obj.students.count()

    def changelist_view(self, request, extra_context=None):        
        qs = self.queryset(request)
        for k,v in request.GET.items():
            #we're only interested in the filter parameters
            if k.find('__') < 0:
                continue
            q = Q(**{k: v}) #looks like magic? see http://stackoverflow.com/questions/5092336/a-better-way-than-eval-when-translating-keyword-arguments-in-querysets-python
            qs = qs.filter(q)
        total_users = qs.aggregate(Sum('number_of_users'))
        my_context = {
            'total_users': total_users['number_of_users__sum'],
        }
        return super(SessionAdmin, self).changelist_view(request,
            extra_context=my_context)

admin.site.register(Session, SessionAdmin)

admin.site.register(SessionType)
admin.site.register(SessionFormat)
admin.site.register(Librarian)

class StudentAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.IntegerField: {'widget': TextInput(attrs={'size':'10'})},
        }
    #fields = ['first_name', 'last_name', 'wsu_id', 'network_id']
    filter_vertical = ('sessions',)

admin.site.register(Student, StudentAdmin)
admin.site.register(Location)

def import_students(session, csv_file):
    '''Receives a csv file with student ids and links them students
        to a session'''
    import csv
    #create a list of IDs from csv file
    student_ids = []
    id_reader = csv.reader(csv_file)
    for row in id_reader:
        student_ids.append(row)
    #get or create students in database    
    dbstudents = []    
    for row in student_ids:
        student_id = row[0] #only interested in the first element, wsu_id
        try:
            idnumber = int(student_id)
        except ValueError:
            continue
        try:
            
            dbstudent = Student.objects.get(wsu_id=idnumber)
            dbstudents.append(dbstudent)
        except Student.DoesNotExist:
            #create new student
            student = Student(wsu_id=int(student_id))
            student.save()
            dbstudents.append(student)                    
    #assign students to session
    for student in dbstudents:        
        session.students.add(student)

        

   
 
