# Generated by Django 4.1.3 on 2022-11-05 19:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_book_description'),
    ]

    operations = [
        migrations.AddField(
            model_name='bookcopy',
            name='owner_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='api.users'),
        ),
    ]
