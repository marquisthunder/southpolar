from tastypie.resources import ModelResource
from serviceconf.models import ServiceConf
from tastypie.authentication import ApiKeyAuthentication


class ServiceConfResource(ModelResource):

    class Meta:
        queryset = ServiceConf.objects.all()
        resource_name = "conf"
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get']
