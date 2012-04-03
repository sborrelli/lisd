from django.shortcuts import render_to_response, get_object_or_404
from django.template.loader import render_to_string
from django.http import Http404, HttpResponse
from lis.models import Course, Session
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
    if request.POST:        
        if not (request.POST['from_date'] and request.POST['to_date']):
            params['error_message'] = "Please enter valid dates"
        else:
            try:
                sessions = Session.objects.filter(date__range=(request.POST['from_date'],
                                                       request.POST['to_date'])).order_by('date')
                params['from_date'] = request.POST['from_date']
                params['to_date'] = request.POST['to_date']
                params['sessions'] = sessions
                params['queried'] = True
                for s in sessions:
                    total += s.course.students.count()
                    totalunique.extend(s.course.students.all())
                params['total'] = total
                params['totalunique'] = len(set(totalunique))
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
    students = []
    if request.POST:
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
            studs.append(c.students.all())
        if len(studs) > 0:
            students = studs[0]            
        for i in range(1, len(studs)):
            #inter = set(students).intersection(studs[i])
            inter = [ x for x in students if x in studs[i] ]
            #students = list(inter)
            students = inter
        params['students'] = students
        params['courses_list'] = "-".join(selected_ids)
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

##def excelample(request):
##    response = HttpResponse(mimetype="application/ms-excel")
##    response['Content-Disposition'] = 'attachment; filename=file.xls'
##    
##    wb = xlwt.Workbook()
##    ws = wb.add_sheet('Sheetname')
##    
##    ws.write(0, 0, 'Firstname')
##    ws.write(0, 1, 'Surname')
##    ws.write(1, 0, 'Hans')
##    ws.write(1, 1, 'Muster')
##
##    wb.save(response)
##    return response

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
    

