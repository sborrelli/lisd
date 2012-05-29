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
    
