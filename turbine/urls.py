from django.conf.urls.defaults import patterns, url
from django.views.generic.base import TemplateView

urlpatterns = patterns('',
                       url(r'^$', TemplateView.as_view(template_name='turbines.jade')),
                       url(r'^get/$', TemplateView.as_view(template_name='turbine-detail.jade')),
                       )
