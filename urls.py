from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('lis.views',
    url(r'^$','default'),
    url(r'^courses/$', 'courses'),
    url(r'^sessions/$', 'sessions'),
    url(r'^enrollment/(?P<course_id>\d+)/$', 'enrollment'),
    url(r'^students_by_courses/$', 'students_by_courses'),
    
    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
