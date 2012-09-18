from django.db import models
from member.models import Member


class ServiceConf(models.Model):
    member = models.OneToOneField(Member, verbose_name='Member')
    etlconf = models.TextField(null=True, blank=True)
    dspconf = models.TextField(null=True, blank=True)
    firstmodify = models.CharField(max_length=30, verbose_name='firstmodify')
    lastmodify = models.CharField(max_length=30, verbose_name='lastmodify')
    addition = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return "Member:%s, Gourp:%s, serviceconf_id:%s ." % (self.member.user.username, self.member.group, self.id)
