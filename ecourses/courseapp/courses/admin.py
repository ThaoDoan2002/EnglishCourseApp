from django.contrib import admin
from .models import Category,Course, Lesson, User, Video




class CourseAdmin(admin.ModelAdmin):
    # Lọc danh sách người dùng trong trường teacher chỉ hiện người dùng có is_teacher=True
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "teacher":
            kwargs["queryset"] = User.objects.filter(is_teacher=True)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)


class UserAdmin(admin.ModelAdmin):
    list_display = ['pk','username']


class CategoryAdmin(admin.ModelAdmin):
    list_display = ['pk', 'name']
    search_fields = ['name']
    list_filter = ['id', 'name']


admin.site.register(Category, CategoryAdmin)
admin.site.register(Course, CourseAdmin)
admin.site.register(Lesson)
admin.site.register(User,UserAdmin)
admin.site.register(Video)

