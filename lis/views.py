from django.shortcuts import render_to_response, get_object_or_404
from django.template.loader import render_to_string
from django.http import Http404, HttpResponse
from lis.models import Course, Session, Librarian, SessionType
from django.template import RequestContext
from django.core.exceptions import ValidationError
import xlwt


def courses(request):
    courses = Course.objects.all()
    return render_to_response('lis/reports.html', {'courses_list' : courses})

def sessions(request):
    params = dict()
    total = 0
    totalunique = []
    #retrieve lists of librarians and ses types
    params['librarians'] = Librarian.objects.order_by('last_name')
    params['session_types'] = SessionType.objects.order_by('name')
    if request.POST:        
        if not (request.POST['from_date'] and request.POST['to_date']):
            params['error_message'] = "Please enter valid dates"
        else:
            try:
                sessions = Session.objects.filter(date__range=(request.POST['from_date'],
                                                       request.POST['to_date'])).order_by('date')
                if request.POST['librarian'] != '0':
                    sessions = sessions.filter(librarian=request.POST['librarian'])
                if request.POST['session_type'] != '0':
                    sessions = sessions.filter(session_type=request.POST['session_type'])
        
                params['sessions'] = sessions
                params['queried'] = True
                for s in sessions:
                    if s.course:
                        total += s.students.count()
                        totalunique.extend(s.students.all())
                params['total'] = total
                params['totalunique'] = len(set(totalunique))
                #re-set the POST parameters to show them again
                params['from_date'] = request.POST['from_date']
                params['to_date'] = request.POST['to_date']
                params['librarian'] = request.POST['librarian']
            except ValidationError:
                params['error_message'] = "Please enter valid dates"
        if request.POST['responsetype'] == "excel":                        
            htmlstring = render_to_string('lis/sessions.html', params,
                              context_instance=RequestContext(request))
            return table_to_excel(request, htmlstring, "Sessions by date")
    else:        
        params['query'] = False
    return render_to_response('lis/sessions.html', params,
                              context_instance=RequestContext(request))
    
    

def students_by_courses(request):
    params = dict()
    courses = Course.objects.all()
    params['courses'] = courses
    students = [] #list of lists of students
    if request.POST:
        if not (request.POST['from_date'] and request.POST['to_date']):
            params['error_message'] = "Please enter valid dates"
        else:    
            params['queried'] = True
            studs = []
            if request.POST['responsetype'] == 'excel':
                selected_ids = request.POST['courses_list'].split('-')
            else:
                selected_ids = request.POST.getlist('courses')
            selected_courses = [ c for c in courses if str(c.course_id) in selected_ids ]
            params['sel_courses'] = ", ".join([ n.full_name() for n in selected_courses ])
            for cid in selected_ids:            
                c = Course.objects.get(pk=int(cid))
                #for every course, get the list of sessions that are related to it. Students are related to these sessions
                sessions = Session.objects.filter(course=c, date__range=(request.POST['from_date'],
                                                           request.POST['to_date']))
                if sessions:
                    ses_students = set() #single set for all students of this course 
                    for ses in sessions:
                        ses_students.update(ses.students.all())                
                    if ses_students:
                        #convert set to list before appending 
                        studs.append(list(ses_students))
            if len(studs) > 0:
                students = studs[0]            
            for i in range(1, len(studs)):
                #inter = set(students).intersection(studs[i])
                inter = [ x for x in students if x in studs[i] ]
                #students = list(inter)
                students = inter
            params['students'] = students
            params['courses_list'] = "-".join(selected_ids)
            #re-set the POST parameters to show them again
            params['from_date'] = request.POST['from_date']
            params['to_date'] = request.POST['to_date']
            if request.POST['responsetype'] == "excel":                        
                htmlstring = render_to_string('lis/students_by_courses.html', params,
                                  context_instance=RequestContext(request))
                return table_to_excel(request, htmlstring, "Students by courses")
    else:        
        params['queried'] = False        
    return render_to_response('lis/students_by_courses.html', params,
                              context_instance=RequestContext(request))

def enrollment(request, course_id):
    c = get_object_or_404(Course, pk=course_id)
    students = c.students.all()
    return render_to_response('lis/enrollment.html', {'course' : c,
                                                      'students' : students})

def table_to_excel(request, htmlstring, bookname):
    response = HttpResponse(mimetype="application/ms-excel")
    response['Content-Disposition'] = 'attachment; filename=%s.xls' % (bookname)
    #create workbook
    wb = xlwt.Workbook()
    ws = wb.add_sheet(bookname) 
    #find table
    nextrow = -1
    tablestart = htmlstring.find('<table')
    if tablestart > -1:
        htmlstring = htmlstring.replace('th>','td>')
        nextrow = tablestart        
        #for each row
        for i in range(htmlstring.count('<tr', tablestart)):
            nextrow = htmlstring.find('<tr', nextrow + 1)
            endrow = htmlstring.find('</tr>', nextrow + 1)
            cellstart = nextrow
            cellend = -1
            for j in range(htmlstring.count('<td', nextrow, endrow)):
                #write cells
                cellstart = htmlstring.find('<td', cellstart + 1)
                cellend = htmlstring.find('</td', cellstart + 1)
                #strip <a> tags
                linkstart = htmlstring.find('<a ', cellstart, cellend)
                if linkstart > -1:
                    cellstart = htmlstring.find('>', linkstart)
                    cellend = htmlstring.find('</a>', cellstart + 1)
                    cellcontent = htmlstring[cellstart+1:cellend]
                else:
                    cellcontent = htmlstring[cellstart+4:cellend]
                #print "row", i, "col", j, "cont:", cellcontent                
                ws.write(i, j, cellcontent)
                cellstart = cellend
            nextrow = endrow
    wb.save(response)
    return response    
    
def default(request):
    return render_to_response('lis/default.html')
