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

from django import forms
from django.contrib import admin
from lis.models import Session, Student
from django.forms import TextInput

class SessionAdminForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(SessionAdminForm, self).__init__(*args, **kwargs)

    students_list = forms.FileField(required=False,
                        help_text='''Use this to upload a text file
                        with WSU ID numbers for this session.<br>If provided,
                        it will clear all previously associated students.''')
    clear_existing = forms.BooleanField(required=False)

    class Meta:
        model = Session
        widgets = {
          'description': TextInput(attrs={'size':'60em'}),
        }
    
