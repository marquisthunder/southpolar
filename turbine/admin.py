from django.contrib import admin
from turbine.models import TurbineParameter, Turbine, TurbineAlarm, TurbineState, TurbineData


admin.site.register(TurbineParameter)
admin.site.register(Turbine)
admin.site.register(TurbineAlarm)
admin.site.register(TurbineState)
admin.site.register(TurbineData)
