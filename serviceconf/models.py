from django.db import models
from member.models import Member


class ServiceConf(models.Model):
    kaasmember = models.OneToOneField(Member, verbose_name='KaasMember')
    etlconf = models.TextField(null=True, blank=True)
    dspconf = models.TextField(null=True, blank=True)
    firstmodify = models.CharField(max_length=30, verbose_name='firstmodify')
    lastmodify = models.CharField(max_length=30, verbose_name='lastmodify')
    addition = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return "KaasMember:%s, Gourp:%s, serviceconf_id:%s ." % (self.kaasmember.user.username, self.kaasmember.group, self.id)
