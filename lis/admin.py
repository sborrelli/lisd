from lis.models import *
from django.contrib import admin

class CourseAdmin(admin.ModelAdmin):
    fields = ['academic_field', 'academic_course_number', 'section',
              'instructor', 'academic_location', 'academic_term',
              'snapshot_date','students']

    list_display = ('full_name', 'academic_term', 'snapshot_date')

admin.site.register(Course, CourseAdmin)

class SessionAdmin(admin.ModelAdmin):
    fields = ['date', 'session_type', 'librarian', 'session_format', 
              'description', 'location', 'course',
              'number_of_users', 'gov_docs']

    list_display = ('date', 'session_type', 'librarian', 'course')

    list_filter = ['date', 'session_type', 'librarian']

admin.site.register(Session, SessionAdmin)

admin.site.register(SessionType)
admin.site.register(SessionFormat)
admin.site.register(Librarian)
admin.site.register(Student)
admin.site.register(Location)
