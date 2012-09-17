from django.db import models
from django.contrib.auth.models import User
from tastypie.models import create_api_key

models.signals.post_save.connect(create_api_key, sender=User)


class MemberManager(models.Manager):

    def get_query_set(self):
        return super(MemberManager, self).get_query_set().filter(user__is_active=True)


class Member(models.Model):
    user = models.ForeignKey(User)
    group = models.CharField(max_length=30, verbose_name=u'Member Group')
    objects = MemberManager()

    def __unicode__(self):
        return "KaasMember:%s, Gourp:%s" % (self.user.username, self.group)
