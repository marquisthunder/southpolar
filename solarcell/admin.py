from django.contrib import admin
from solarcell.models import SolarcellParameter, Solarcell, SolarcellAlarm, SolarcellState, SolarcellData


admin.site.register(SolarcellParameter)
admin.site.register(Solarcell)
admin.site.register(SolarcellAlarm)
admin.site.register(SolarcellState)
admin.site.register(SolarcellData)
