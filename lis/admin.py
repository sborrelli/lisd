from lis.models import *
from django.contrib import admin

class CourseAdmin(admin.ModelAdmin):
    fields = ['academic_field', 'academic_course_number', 'instructor',
              'course_location', 'academic_location', 'academic_term',
              'snapshot_date','students']

    list_display = ('academic_term', 'academic_field', 'academic_course_number')

admin.site.register(Course, CourseAdmin)

class SessionAdmin(admin.ModelAdmin):
    fields = ['date', 'session_type', 'session_format', 'librarian', 'location',
              'course','gov_docs']

    list_display = ('date', 'session_type', 'librarian')

    list_filter = ['date', 'session_type']

admin.site.register(Session, SessionAdmin)

admin.site.register(SessionType)
admin.site.register(SessionFormat)
admin.site.register(Librarian)
admin.site.register(Student)
