from django.conf.urls import patterns, include, url
from member.resource import MemberResource
from member.resource import UserResource
from report.resource import ReportResource
from portal.resource import PortalResource
from serviceconf.resource import ServiceConfResource
from django.contrib import admin
from tastypie.api import Api

#api objects
members_api = Api(api_name='members')
members_api.register(UserResource())
members_api.register(MemberResource())
members_api.register(PortalResource())

service_api = Api(api_name='service')
service_api.register(ServiceConfResource())

report_api = Api(api_name='report')
report_api.register(ReportResource())

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'portal.views.home', name='home'),
    url(r'^api/', include(members_api.urls)),
    url(r'^api/', include(service_api.urls)),
    url(r'^api/', include(report_api.urls)),
    url(r'^members/', include('member.urls')),
    url(r'^portal/', include('portal.urls')),
    url(r'^service/', include('serviceconf.urls')),
    url(r'^report/', include('report.urls')),
    url(r'^turbine/', include('turbine.urls')),
    url(r'^solarcell/', include('solarcell.urls')),
    url(r'^surveillance/', include('surveillance.urls')),
    url(r'^meteor/', include('meteor.urls')),
    url(r'^power/', include('power.urls')),
    url(r'^battery/', include('battery.urls')),
    url(r'^admin/', include(admin.site.urls)),
)
