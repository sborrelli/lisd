from django.shortcuts import render_to_response
##from django.template import Context, loader
##from django.http import HttpResponse
from django.http import Http404
from lis.models import Course, Session


def reports(request):
    courses = Course.objects.all()    
##    t = loader.get_template('lis/reports.html')
##    c = Context({
##        'courses_list' : courses
##        })    
##    return HttpResponse(t.render(c))
    return render_to_response('lis/reports.html', {'courses_list' : courses})

def sessions(request, course_id):
    try:
        c = Course.objects.get(pk=course_id)
        sessions = Session.objects.filter(course=c)
    except Course.DoesNotExist:
        raise Http404
    return render_to_response('lis/sessions.html', {'course' : c,
                                                    'sessions' : sessions})
