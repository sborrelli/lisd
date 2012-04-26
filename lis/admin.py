from lis.models import *
from django.contrib import admin

class CourseAdmin(admin.ModelAdmin):
    fields = ['academic_field', 'academic_course_number', 'description', 'academic_location']

    list_display = ('full_name',)

admin.site.register(Course, CourseAdmin)

class SessionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,                  {'fields': ['date', 'session_type', 'librarian',
                                           'librarians', 'session_format', 'description',
                                           'number_of_users', 'gov_docs']}),
        ('Course Information',  {'fields': ['course', 'section',
                                           'academic_term', 'instructor']}),
        ('Students',            {'fields': ['students'], 'classes': ['collapse']}),                        
    ]    

    list_display = ('date', 'session_type', 'librarian', 'course')

    list_filter = ['date', 'session_type', 'librarian']

admin.site.register(Session, SessionAdmin)

admin.site.register(SessionType)
admin.site.register(SessionFormat)
admin.site.register(Librarian)
admin.site.register(Student)
admin.site.register(Location)
