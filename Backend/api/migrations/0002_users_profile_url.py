# Generated by Django 4.1.2 on 2022-10-27 22:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='users',
            name='profile_url',
            field=models.TextField(default=None),
            preserve_default=False,
        ),
    ]
