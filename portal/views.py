# Create your views here.
import logging
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout

logger = logging.getLogger(__name__)

def home(request):
    logger.info("access index")
    return render_to_response('index.jade', context_instance=RequestContext(request))
