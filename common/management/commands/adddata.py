from django.core.management.base import BaseCommand
from turbine.models import *
import random
import time


class Command(BaseCommand):

    help = 'add some test data'

    def handle(self, *args, **options):
        alarms = list(TurbineAlarm.objects.all())
        states = list(TurbineState.objects.all())

        turbine = list(Turbine.objects.al())
        while(True):
            turbinedata = TurbineData.objects.create(turbine=random.list(turbine),
                                                     status=random.choice([True, False]),
                                                     power=random.randint(0, 100),
                                                     windspeed=random.randint(0, 20),
                                                     alarm=random.choice(alarms),
                                                     state=random.choice(states))
            self.stdout.write('"%s"' % turbinedata)
            time.sleep(0.1)
