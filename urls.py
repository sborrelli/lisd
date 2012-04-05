from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^courses/$', 'lis.views.courses'),
    url(r'^sessions/$', 'lis.views.sessions'),
    url(r'^enrollment/(?P<course_id>\d+)/$', 'lis.views.enrollment'),
    url(r'^students_by_courses/$', 'lis.views.students_by_courses'),
    #url(r'^excel/$', 'lis.views.excelample'),                       
    #url(r'^listall/(?P<course_id>\d+)/$', 'lis.views.listall'),
    # Examples:
    # url(r'^$', 'sdw.views.home', name='home'),
    # url(r'^sdw/', include('sdw.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
