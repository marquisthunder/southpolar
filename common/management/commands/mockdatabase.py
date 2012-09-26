from django.core.management.base import BaseCommand
from turbine.models import Turbine, TurbineAlarm, TurbineData, TurbineState
import random
import time


class Command(BaseCommand):

    help = 'add some test data'

    def handle(self, *args, **options):
        alarms = list(TurbineAlarm.objects.all())
        states = list(TurbineState.objects.all())

        turbine = list(Turbine.objects.all())
        dataadded = 0
        while(True):
            turbinedata = TurbineData.objects.create(turbine=random.choice(turbine),
                                                     status=random.choice([True, False]),
                                                     power=random.randint(0, 100),
                                                     windspeed=random.randint(0, 20),
                                                     alarm=random.choice(alarms),
                                                     state=random.choice(states))
            dataadded += 1
            #self.stdout.write('"dataadded:%d"' % dataadded)
            time.sleep(1)
