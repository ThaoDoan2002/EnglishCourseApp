from django.db import models
from django.contrib.auth.models import AbstractUser
from cloudinary.models import CloudinaryField
from .validators import file_size
from django.dispatch import receiver
from django.db.models.signals import post_save


class User(AbstractUser):
    avatar = CloudinaryField('avatar', null=True, blank=True)
    phone = models.CharField(null=True, max_length=255, unique=True)
    is_teacher = models.BooleanField(default=False)
    email = models.EmailField(unique=True)


class Category(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class BaseModel(models.Model):
    created_date = models.DateField(auto_now_add=True, null=True)
    updated_date = models.DateField(auto_now=True, null=True)
    active = models.BooleanField(default=True)

    class Meta:
        abstract = True


class Course(BaseModel):
    name = models.CharField(max_length=255, null=False, unique=True)
    description = models.TextField(null=True, blank=True, max_length=255)
    thumbnail = CloudinaryField('thumbnail', null=True)
    price = models.IntegerField()
    category = models.ForeignKey(Category, on_delete=models.RESTRICT)
    teacher = models.ForeignKey(User, on_delete=models.RESTRICT)

    def __str__(self):
        return self.name


class Lesson(BaseModel):
    subject = models.CharField(max_length=255, null=False)
    thumbnail = CloudinaryField('thumbnail', null=True)
    description = models.TextField(null=True, blank=True, max_length=255)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('subject', 'course')

    def __str__(self):
        return str(self.subject)+" " + str(self.course.name)


class Video(BaseModel):
    name = models.CharField(max_length=255, null=False)
    thumbnail = CloudinaryField('thumbnail', null=True)
    url = models.FileField(upload_to='courses/%Y/%m', validators=[file_size], null=True, blank=True)
    lesson = models.ForeignKey(Lesson, on_delete=models.CASCADE, null=True)

    class Meta:
        unique_together = ('name', 'lesson')

    def __str__(self):
        return self.name


class Payment(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    course = models.ForeignKey(Course, on_delete=models.CASCADE, null=True)
    status = models.BooleanField(default=False)

    class Meta:
        unique_together = ('user', 'course')
