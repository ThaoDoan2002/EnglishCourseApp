# Generated by Django 5.0.8 on 2024-09-27 07:49

import cloudinary.models
import courses.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0008_alter_course_description_alter_lesson_description'),
    ]

    operations = [
        migrations.CreateModel(
            name='Video',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_date', models.DateField(auto_now_add=True, null=True)),
                ('updated_date', models.DateField(auto_now=True, null=True)),
                ('active', models.BooleanField(default=True)),
                ('name', models.CharField(max_length=255, unique=True)),
                ('thumbnail', cloudinary.models.CloudinaryField(max_length=255, null=True, verbose_name='thumbnail')),
                ('video', models.FileField(blank=True, null=True, upload_to='courses/%Y/%m', validators=[courses.validators.file_size])),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
