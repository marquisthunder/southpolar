from django.db import models
import datetime
# Create your models here.



class SolarcellParameter(models.Model):
    kp = models.IntegerField(verbose_name=u'KP')
    ki = models.IntegerField(verbose_name=u'KI')
    kd = models.IntegerField(verbose_name=u'KD')

    def __unicode__(self):
        return u'[Solarcell Parameter:%s]' % (self.kp, self.ki, self.kd)


class Solarcell(models.Model):
    name = models.CharField(max_length=30, verbose_name='SolarcellName')
    producer = models.CharField(max_length=30, verbose_name='SolarcellName')
    ratedpower = models.IntegerField(verbose_name='Rated Power')
    parameter = models.ForeignKey(SolarcellParameter, verbose_name='Parameter')
    date_installed = models.DateTimeField('date installed', default=datetime.datetime.now)

    class Meta:
        verbose_name = 'Solarcell'

    def __unicode__(self):
        return u'[Solarcell:%s]' % self.name


class SolarcellAlarm(models.Model):
    type = models.TextField(verbose_name=u'Alarm Type')

    def __unicode__(self):
        return u'[Solarcell Alarm:%s]' % self.type


class SolarcellState(models.Model):
    type = models.TextField(verbose_name=u'State Type')

    def __unicode__(self):
        return u'[Solarcell State:%s]' % self.type


class SolarcellData(models.Model):
    turbine = models.ForeignKey(Solarcell)
    status = models.BooleanField()
    currentpower = models.IntegerField(default=0)
    alarminfo = models.OneToOneField(SolarcellAlarm, verbose_name='Alarm')
    state = models.OneToOneField(SolarcellState, verbose_name='State')
