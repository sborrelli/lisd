from lis.models import *
from django.contrib import admin
from django.forms import TextInput
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
    fieldsets = [
        (None,                  {'fields': ['campus', 'session_format', 'date', 'academic_term', 'session_type',
                                            'description', 'course', 'section',
                                           'instructor', 'librarian', 
                                           'number_of_users', 'gov_docs'],
                                 'description': 'Fields in <b>boldface</b> are required.<br>'}),
        ('Multiple Librarians',            {'fields': ['librarians'], 'classes': ['collapse']}),
        ('Students',            {'fields': ['students'], 'classes': ['collapse']})
    ]    

    list_display = ('date', 'session_type', 'librarian', 'course')

    list_filter = ['date', 'session_type', 'librarian']

    def save_model(self, request, obj, form, change):
        if not len(obj.academic_term) > 0:
            obj.academic_term = calculate_term(obj.date)
        obj.save()

admin.site.register(Session, SessionAdmin)

admin.site.register(SessionType)
admin.site.register(SessionFormat)
admin.site.register(Librarian)

class StudentAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.IntegerField: {'widget': TextInput(attrs={'size':'10'})},
        }
    #fields = ['first_name', 'last_name', 'wsu_id', 'network_id']

admin.site.register(Student, StudentAdmin)
admin.site.register(Location)
