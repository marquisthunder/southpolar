from django.conf.urls.defaults import patterns, url
from django.views.generic.base import TemplateView

urlpatterns = patterns('',
    url(r'^serviceconf/$', TemplateView.as_view(template_name='serviceconf.html')),
)
