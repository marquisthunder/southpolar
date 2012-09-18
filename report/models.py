from django.db import models
from member.models import Member


class Report(models.Model):
    member = models.OneToOneField(Member, verbose_name='Member')
    contractstart = models.CharField(max_length=30, verbose_name='firstmodify')
    contractend = models.CharField(max_length=30, verbose_name='firstmodify')
    etlhistory = models.TextField(null=True, blank=True)
    dsphistory = models.TextField(null=True, blank=True)
    addition = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return "Member:%s, Gourp:%s, report_id:%s ." % (self.member.user.username, self.member.group, self.id)
