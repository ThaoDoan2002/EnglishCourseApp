# Generated by Django 5.0.8 on 2024-09-27 07:52

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0009_video'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='video',
        ),
        migrations.AddField(
            model_name='video',
            name='lesson',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='courses.lesson'),
        ),
    ]
