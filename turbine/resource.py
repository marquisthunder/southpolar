from tastypie.resources import ModelResource
from tastypie import fields
from tastypie.authentication import ApiKeyAuthentication
from turbine.models import Turbine, TurbineData


class TurbineResource(ModelResource):

    class Meta:
        queryset = Turbine.objects.all()
        resource_name = 'profile'
        authentication = ApiKeyAuthentication()
        fields = ['name', 'type', 'date_installed']
        allowed_methods = ['get']


class TurbineDataResource(ModelResource):
    turbine = fields.ForeignKey(TurbineResource, 'turbine')

    class Meta:
        queryset = TurbineData.objects.all()
        resource_name = "turbinedata"
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get']

    def dehydrate(self, bundle):
        bundle.data['status'] = "Whatever you want"
        return bundle
