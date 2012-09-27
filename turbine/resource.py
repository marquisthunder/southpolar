from tastypie import fields
from tastypie.authentication import ApiKeyAuthentication
from turbine.models import Turbine, TurbineData, TurbineState, TurbineAlarm, TurbineParameter
from tastypie.resources import ModelResource
from django.forms.models import model_to_dict
from django.utils.timezone import now, timedelta
from django.conf.urls import url
from tastypie.serializers import Serializer
from time import mktime


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
        data = model_to_dict(TurbineData.objects.filter(turbine=bundle.data['id']).latest('timestamp'))
        data['alarm'] = TurbineAlarm.objects.get(id=data['alarm']).type
        data['state'] = TurbineState.objects.get(id=data['state']).type
        bundle.data['data'] = data
        bundle.data['parameter'] = model_to_dict(parameter)
        return bundle


class TurbineDataResource(ModelResource):
    serializer = Serializer()
    turbinelist = {turbine['id']: turbine['name'] for turbine in Turbine.objects.all().values()}
    alarmlist = {alarm['id']: alarm['type'] for alarm in TurbineAlarm.objects.all().values()}
    statelist = {state['id']: state['type'] for state in TurbineState.objects.all().values()}

    class Meta:
        queryset = TurbineData.objects.all()

    def prepend_urls(self):
        """
            Returns a URL scheme based on the default scheme to specify
            the response format as a file extension, e.g. /api/v1/users.json
        """
        return [
            url(r"^(?P<resource_name>%s)/(?P<turbineid>[\d]+)/minute$" % self._meta.resource_name,
                self.wrap_view('minutedata'), name="api_get_minutedata"),
            url(r"^(?P<resource_name>%s)/(?P<turbineid>[\d]+)/hour$" % self._meta.resource_name,
                self.wrap_view('hourdata'), name="api_get_hourdata"),
        ]

    def minutedata(self, request, **kwargs):
        id = kwargs['turbineid']
        minutedata = TurbineData.objects.filter(turbine__id=id,
                                                timestamp__gt=now() - timedelta(minutes=1))
        data = list(self.handledata(obj) for obj in minutedata)
        return self.create_response(request, data)

    def hourdata(self, request, **kwargs):
        id = kwargs['turbineid']
        hourdata = TurbineData.objects.filter(turbine__id=id,
                                              timestamp__gt=now() - timedelta(hours=1))
        data = list(self.handledata(obj) for obj in hourdata)
        return self.create_response(request, data)

    def handledata(self, obj):
        dict = model_to_dict(obj, exclude=['id']) 
        dict['alarm'] = self.alarmlist[dict['alarm']]
        dict['state'] = self.statelist[dict['state']]
        dict['timestamp'] = int(1000 * mktime(dict['timestamp'].timetuple()))
        dict['turbine'] = self.turbinelist[dict['turbine']]
        return dict
