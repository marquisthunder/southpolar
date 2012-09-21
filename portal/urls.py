from django.conf.urls.defaults import patterns, url
from django.views.generic.base import TemplateView

urlpatterns = patterns('',
    url(r'^login/$', TemplateView.as_view(template_name='login.jade')),
    url(r'^logout/$', TemplateView.as_view(template_name='logout.jade')),
    url(r'^register/$', TemplateView.as_view(template_name='register.jade')),
)
