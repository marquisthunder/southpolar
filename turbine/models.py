from django.db import models
from django.utils.timezone import now


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
    date_installed = models.DateTimeField('date installed', default=now)

    def __unicode__(self):
        return u'[Turbine:%s]' % self.name


class TurbineAlarm(models.Model):
    type = models.CharField(max_length=100, verbose_name=u'Alarm Type')

    def __unicode__(self):
        return u'[Turbine Alarm:%s]' % self.type


class TurbineState(models.Model):
    type = models.CharField(max_length=100, verbose_name=u'State Type')

    def __unicode__(self):
        return u'[Turbine State:%s]' % self.type


class TurbineData(models.Model):
    turbine = models.ForeignKey(Turbine)
    status = models.BooleanField()
    power = models.IntegerField(default=0)
    windspeed = models.IntegerField(default=0)
    alarm = models.ForeignKey(TurbineAlarm, verbose_name='Alarm')
    state = models.ForeignKey(TurbineState, verbose_name='State')
    timestamp = models.DateTimeField('date inserted', default=now)

    def __unicode__(self):
        return u'[Turbine Power:%d]' % self.power
