# Create your views here.
import logging
from django.shortcuts import render_to_response,redirect
from django.template import RequestContext
from django.contrib import messages
from django.contrib.auth.decorators import permission_required,login_required
from django.contrib.auth.models import User, Group
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout

logger = logging.getLogger(__name__)

def home(request):
    logger.info("access index")
    return render_to_response('index.html', context_instance=RequestContext(request))
