from django.db import models
import datetime


class TurbineParameter(models.Model):
    kp = models.IntegerField(verbose_name=u'KP')
    ki = models.IntegerField(verbose_name=u'KI')
    kd = models.IntegerField(verbose_name=u'KD')

    def __unicode__(self):
        return u'[Turbine Parameter:%d, %d, %d]' % (self.kp, self.ki, self.kd)


class Turbine(models.Model):
    name = models.CharField(max_length=30, verbose_name='TurbineName')
    producer = models.CharField(max_length=30, verbose_name='Producer')
    ratedpower = models.IntegerField(verbose_name='Rated Power')
    parameter = models.ForeignKey(TurbineParameter, verbose_name='Parameter')
    date_installed = models.DateTimeField('date installed', default=datetime.datetime.now)

    def __unicode__(self):
        return u'[Turbine:%s]' % self.name


class TurbineAlarm(models.Model):
    type = models.TextField(verbose_name=u'Alarm Type')

    def __unicode__(self):
        return u'[Turbine Alarm:%s]' % self.type


class TurbineState(models.Model):
    type = models.TextField(verbose_name=u'State Type')

    def __unicode__(self):
        return u'[Turbine State:%s]' % self.type


class TurbineData(models.Model):
    turbine = models.ForeignKey(Turbine)
    status = models.BooleanField()
    currentpower = models.IntegerField(default=0)
    alarminfo = models.OneToOneField(TurbineAlarm, verbose_name='Alarm')
    state = models.OneToOneField(TurbineState, verbose_name='State')
    currentdate = models.DateTimeField('date inserted', default=datetime.datetime.now)

    def __unicode__(self):
        return u'[Turbine Power:%d]' % self.currentpower
