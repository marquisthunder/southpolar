from tastypie.resources import ModelResource
from tastypie import fields
from tastypie.authentication import ApiKeyAuthentication
from turbine.models import Turbine, TurbineData
#from datetime import datetime, timedelta


class TurbineResource(ModelResource):
    '''
    def gettimefilter(self):
        curtime = datatime.now()
        return TurbineDataResource.objects.filter(currenttime__lt=curtime - timedelta(hours=1))
    '''

    class Meta:
        queryset = Turbine.objects.all()
        resource_name = 'turbine'
        authentication = ApiKeyAuthentication()
        #fields = ['name', 'producer', 'parameter', 'date_installed']
        allowed_methods = ['get']


class TurbineDataResource(ModelResource):
    info = fields.ToOneField(TurbineResource, attribute='info', related_name='turbine', full=True, null=True)

    class Meta:
        queryset = TurbineData.objects.all()
        resource_name = "turbinedata"
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get']

    def dehydrate(self, bundle):
        bundle.data['addon'] = "Whatever you want"
        return bundle
