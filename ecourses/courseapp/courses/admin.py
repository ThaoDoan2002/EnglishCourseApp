from django.contrib import admin
from .models import Category,Course, Lesson, Tag
from django import forms
from ckeditor_uploader.widgets import CKEditorUploadingWidget



class CourseForm(forms.ModelForm):
    description = forms.CharField(widget=CKEditorUploadingWidget)
    class Meta:
        model = Course
        fields = '__all__'


class TagInlineAdmin(admin.StackedInline):
    model = Course.tags.through

class CourseAdmin(admin.ModelAdmin):
    form = CourseForm
    inlines = [TagInlineAdmin]


class CategoryAdmin(admin.ModelAdmin):
    list_display = ['pk', 'name']
    search_fields = ['name']
    list_filter = ['id', 'name']


admin.site.register(Category, CategoryAdmin)
admin.site.register(Course, CourseAdmin)
admin.site.register(Lesson)
admin.site.register(Tag)

