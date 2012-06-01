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
