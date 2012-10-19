from django.db import models
from django.utils.timezone import now


class SolarcellParameter(models.Model):
    kp = models.IntegerField(verbose_name=u'KP')
    ki = models.IntegerField(verbose_name=u'KI')
    kd = models.IntegerField(verbose_name=u'KD')

    def __unicode__(self):
        return u'[Solarcell Parameter:%d, %d, %d]' % (self.kp, self.ki, self.kd)


class Solarcell(models.Model):
    name = models.CharField(max_length=30, verbose_name='SolarcellName')
    producer = models.CharField(max_length=30, verbose_name='Producer')
    ratedpower = models.IntegerField(verbose_name='Rated Power')
    parameter = models.ForeignKey(SolarcellParameter, verbose_name='Parameter')
    date_installed = models.DateTimeField('date installed', default=now)

    def __unicode__(self):
        return u'[Solarcell:%s]' % self.name


class SolarcellAlarm(models.Model):
    type = models.CharField(max_length=100, verbose_name=u'Alarm Type')

    def __unicode__(self):
        return u'[Solarcell Alarm:%s]' % self.type


class SolarcellState(models.Model):
    type = models.CharField(max_length=100, verbose_name=u'State Type')

    def __unicode__(self):
        return u'[Solarcell State:%s]' % self.type


class SolarcellData(models.Model):
    solarcell = models.ForeignKey(Solarcell, verbose_name='Solarcell')
    status = models.BooleanField()
    power = models.IntegerField(default=0)
    alarm = models.ForeignKey(SolarcellAlarm, verbose_name='Alarm')
    state = models.ForeignKey(SolarcellState, verbose_name='State')
    timestamp = models.DateTimeField('date inserted', default=now)

    def __unicode__(self):
        return u'[Solarcell Power:%d]' % self.power
