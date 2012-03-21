from django.shortcuts import render_to_response, get_object_or_404
from django.http import Http404
from lis.models import Course, Session
from django.template import RequestContext


def courses(request):
    courses = Course.objects.all()
    return render_to_response('lis/reports.html', {'courses_list' : courses})

def sessions(request):
    params = dict()
    if request.POST:        
        if not (request.POST['from_date'] and request.POST['to_date']):
            params['error_message'] = "Please enter valid dates"
        else:
            sessions = Session.objects.filter(date__range=(request.POST['from_date'],
                                                       request.POST['to_date'])).order_by('date')
            params['from_date'] = request.POST['from_date']
            params['to_date'] = request.POST['to_date']
            params['sessions'] = sessions
            params['queried'] = True
    else:
        message = "Geteo"
        params['query'] = False
    return render_to_response('lis/sessions.html', params,
                              context_instance=RequestContext(request))

def enrollment(request, course_id):
    c = get_object_or_404(Course, pk=course_id)
    students = c.students.all()
    return render_to_response('lis/enrollment.html', {'course' : c,
                                                      'students' : students})


    

