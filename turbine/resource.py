from tastypie import fields
from tastypie.authentication import ApiKeyAuthentication
from turbine.models import Turbine, TurbineData, TurbineState, TurbineAlarm, TurbineParameter
from tastypie.resources import ModelResource
from django.forms.models import model_to_dict
from django.utils.timezone import now, timedelta
from django.conf.urls import url
import copy


class TurbineParameterResource(ModelResource):

    class Meta:
        queryset = TurbineParameter.objects.all()
        resource_name = 'turbineparameter'
        excludes = ['id']
        allowed_methods = ['get', 'post']


class TurbineResource(ModelResource):

    class Meta:
        queryset = Turbine.objects.all()
        resource_name = 'turbine'
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get']

    def alter_list_data_to_serialize(self, request, data_dict):
        if isinstance(data_dict, dict):
            if 'meta' in data_dict:
                # Get rid of the "meta".
                del(data_dict['meta'])
        return data_dict

    def dehydrate(self, bundle):
        parameter = Turbine.objects.get(id=bundle.data['id']).parameter
        data = TurbineData.objects.filter(turbine=bundle.data['id']).latest('timestamp')
        bundle.data['data'] = model_to_dict(data)
        bundle.data['parameter'] = model_to_dict(parameter)
        return bundle


class TurbineDataResource(ModelResource):
    status = fields.BooleanField(default=False, attribute='status')
    windspeed = fields.IntegerField(attribute='windspeed', null=True)
    power = fields.IntegerField(attribute='power', null=True)
    state = fields.CharField(attribute='state__type')
    alarm = fields.CharField(attribute='alarm__type')

    class Meta:
        queryset = TurbineData.objects.all()

    def prepend_urls(self):
        """
            Returns a URL scheme based on the default scheme to specify
            the response format as a file extension, e.g. /api/v1/users.json
        """
        return [
            url(r"^(?P<resource_name>%s)/minute$" % self._meta.resource_name,
                self.wrap_view('minutedata'), name="api_get_minutedata"),
            url(r"^(?P<resource_name>%s)/hour$" % self._meta.resource_name,
                self.wrap_view('hourdata'), name="api_get_hourdata"),
        ]

    def minutedata(self, request, **kwargs):
        minutedata = TurbineData.objects.filter(currenttime__lt=now - timedelta(minutes=1))
        return self.create_response(request, model_to_dict(minutedata))

    def hourdata(self, request, **kwargs):
        hourdata = TurbineData.objects.filter(currenttime__lt=now - timedelta(hours=1))
        return self.create_response(request, model_to_dict(hourdata))
