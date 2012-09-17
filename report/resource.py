from tastypie.resources import ModelResource
from report.models import Report
from tastypie.authentication import ApiKeyAuthentication

class ReportResource(ModelResource):
    class Meta:
        queryset = Report.objects.all()
        resource_name = "view"
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get']
