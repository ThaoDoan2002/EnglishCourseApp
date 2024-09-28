# Generated by Django 5.0.8 on 2024-09-17 07:05

import cloudinary.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='lesson_number',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='course',
            name='video',
            field=cloudinary.models.CloudinaryField(max_length=255, null=True, verbose_name='video'),
        ),
        migrations.AddField(
            model_name='course',
            name='video_length',
            field=models.IntegerField(null=True),
        ),
        migrations.AlterField(
            model_name='course',
            name='thumbnail',
            field=cloudinary.models.CloudinaryField(max_length=255, null=True, verbose_name='thumbnail'),
        ),
    ]
