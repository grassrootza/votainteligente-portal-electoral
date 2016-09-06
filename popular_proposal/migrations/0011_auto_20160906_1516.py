# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-09-06 15:16
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('popular_proposal', '0010_commitment_commited'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='popularproposal',
            options={'ordering': ['-created']},
        ),
        migrations.AddField(
            model_name='popularproposal',
            name='for_all_areas',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='commitment',
            name='candidate',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='commitments', to='elections.Candidate'),
        ),
        migrations.AlterField(
            model_name='commitment',
            name='proposal',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='commitments', to='popular_proposal.PopularProposal'),
        ),
    ]
