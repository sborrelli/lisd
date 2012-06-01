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

Library Intruction Sessions Database
=====================================

LISD is a system to record "instruction sessions" by librarians to students and visitors at the University. It's made using the Django framework. This document describes briefly the technical details of the system.

Platform
--------
LISD is made on Python, using the Django v1.3 web application framework. As such, it's database independent; the initial implementation uses MySQL but it should work fine with Postgres, Oracle or even SQLite.

Dependencies
------------

Besides django, LISD uses
- xlwt: a library to export query results as excel files
- jQuery and jQueryUI
- Blueprint CSS

They're all included in subfolders, and should work right away.

Data Model
----------

The system has one Django app (besides the Admin), called "lis". The lis.models module defines the following entities:

- Session: the "main" entity in the application, it represents a library instruction session. It has a related Librarian, Location, SessionFormat, SessionType, and optionally a link to a course and it's students. The Students are related in a many-to-many relationship to Sessions, and are loaded from a CSV file with Student IDs in the first column.
- Librarian: the librarian in charge of the session.
- Course: Courses are very simple -just a code and a description- and we use them as a reference to get a students list from the university's students database.
- Student: Represent a student. It can have names and other data, but for privacy reasons, the only thing required is a Student ID. That way we can keep make queries linking students to sessions, without the need to identify them by name or other sensitive information.
- SessionType: Just a list of session types to be displayed in a dropdown menu, like Composition, Tour, Workshop, etc.
- SessionFormat: List of formats for a dropdown menu. Originally, either "in person" or "online".
- Location: Campuses.

Besides the model classes, the module has several auxiliary functions used for calculating default values for certain
Session fields.

Admin screens
-------------

The default Admin views were mofidified using the lis.admin module. The main changes are
- SessionAdmin: display list. Custom methods
	- save_model: overrides the parent method to calculate academic_term based on the date, and to import students
	from a CSV file if provided.
	- enrolled_students: calculates student count to display in the change list.
	- changelist_view: overrides parent to calculate a total of the number_of_users field for display

- import_students: auxiliary method called from SessionAdmin.save_model to import students from a CSV file.

Query Views
-----------

The views are queries that can be exported to Excel files. There are two of them:

- lis.views.sessions: displays a list of sessions filtered by date, librarian and session type. 
- lis.views.students_by_courses: user can select one or more courses, and a date range, and get a list of students that were enrolled in ALL of them (intersection).

Installation
------------

To install and run the application, you need to

1. Download the zip bundle from the project website at http://code.google.com/p/lisd/
2. Have python 2.7+ and django 1.3+ installed in your host/server
3. Unzip
4. Manage.py syncdb
5. Optionally, load DB with the sample data provided, sample_data.sql in db folder. The file is a MySQL script.



