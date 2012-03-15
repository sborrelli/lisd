from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^reports/$', 'lis.views.reports'),
    url(r'^reports/(?P<course_id>\d+)/$', 'lis.views.sessions'),                   
    # Examples:
    # url(r'^$', 'sdw.views.home', name='home'),
    # url(r'^sdw/', include('sdw.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
