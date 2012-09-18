from tastypie.authentication import Authentication
from django.contrib.auth import authenticate, login as auth_login
from tastypie.models import ApiKey
import json


class LoginAuthentication(Authentication):
    user = None

    def is_authenticated(self, request, **kwargs):
        if request.method == 'POST':
            postdict = json.loads(request.POST.keys()[0])
            username = postdict.get('username')
            password = postdict.get('password')
            self.user = authenticate(username=username, password=password)
            if self.user:
                auth_login(request, self.user)
                return True
            else:
                return False

    # Optional but recommended
    def get_identifier(self, request):
        try:
            apikey = ApiKey.objects.get(user=self.user)
        except:
            return None
        else:
            return apikey.key
