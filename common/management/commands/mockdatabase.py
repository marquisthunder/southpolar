from django.core.management.base import BaseCommand
from turbine.models import Turbine, TurbineAlarm, TurbineData, TurbineState
from solarcell.models import Solarcell, SolarcellAlarm, SolarcellData, SolarcellState
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

    def handle(self, *args, **options):
        alarms = list(SolarcellAlarm.objects.all())
        states = list(SolarcellState.objects.all())

        solarcell = list(Solarcell.objects.all())
        dataadded1 = 0
        while(True):
            solarcelldata = SolarcellData.objects.create(solarcell=random.choice(solarcell),
                                                         status=random.choice([True, False]),
                                                         power=random.randint(0, 600),
                                                         alarm=random.choice(alarms),
                                                         state=random.choice(states))
            dataadded1 += 1
            #self.stdout.write('"dataadded:%d"' % dataadded)
            time.sleep(1)
