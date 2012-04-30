from lis.models import *
from django.contrib import admin

class CourseAdmin(admin.ModelAdmin):
    fields = ['academic_field', 'academic_course_number', 'description', 'academic_location']

    list_display = ('full_name',)

admin.site.register(Course, CourseAdmin)

class SessionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,                  {'fields': ['session_format', 'date', 'academic_term', 'session_type',
                                            'description', 'course', 'section',
                                           'instructor', 'librarian', 'librarians',
                                           'number_of_users', 'gov_docs']}),
        ('Students',            {'fields': ['students'], 'classes': ['collapse']})
    ]    

    list_display = ('date', 'session_type', 'librarian', 'course')

    list_filter = ['date', 'session_type', 'librarian']

admin.site.register(Session, SessionAdmin)

admin.site.register(SessionType)
admin.site.register(SessionFormat)
admin.site.register(Librarian)
admin.site.register(Student)
admin.site.register(Location)
