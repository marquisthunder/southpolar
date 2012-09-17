#from member.resource import UserResource
#from tastypie import fields
from django.contrib.auth.models import User
from django.conf.urls import url
from tastypie.resources import ModelResource
from member.models import Member
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from tastypie.http import HttpUnauthorized, HttpForbidden
from tastypie.models import ApiKey


class PortalResource(ModelResource):
    class Meta:
        allowed_methods = ['get', 'post']
        resource_name = 'portal'

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/login/?$" % self._meta.resource_name,
                self.wrap_view('login'), name="api_login"),
            url(r'^(?P<resource_name>%s)/logout/?$' % self._meta.resource_name,
                self.wrap_view('logout'), name='api_logout'),
            url(r'^(?P<resource_name>%s)/checkusername/?$' % self._meta.resource_name,
                self.wrap_view('checkusername'), name='api_checkusername'),
            url(r'^(?P<resource_name>%s)/register/?$' % self._meta.resource_name,
                self.wrap_view('register'), name='api_register'),
        ]

    def register(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        data = self.deserialize(request, request.raw_post_data,
                                format=request.META.get('CONTENT_TYPE', 'application/json'))
        print data
        username = data.get('username', '')
        password = data.get('password', '')
        group = data.get('group', '')
        try:
            user = User.objects.create(username=username, password=password)
            Member.objects.create(user=user, group=group)
        except:
            return self.create_response(request, {
                'success': True,
                'reason': 'username Valid',
            })
        else:
            return self.create_response(request, {
                'success': False,
                'reason': 'Service Error',
            })

    def checkusername(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        data = self.deserialize(request, request.raw_post_data,
                                format=request.META.get('CONTENT_TYPE', 'application/json'))
        username = data.get('username', '')
        try:
            Member.objects.get(user__username=username)
        except:
            return self.create_response(request, {
                'success': True,
                'reason': 'username Valid',
            })
        else:
            return self.create_response(request, {
                'success': False,
                'reason': 'username Exists',
            })

    def login(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        data = self.deserialize(request, request.raw_post_data,
                                format=request.META.get('CONTENT_TYPE', 'application/json'))

        username = data.get('username', '')
        password = data.get('password', '')

        user = authenticate(username=username, password=password)
        if user:
            if user.is_active:
                auth_login(request, user)
                try:
                    apikey = ApiKey.objects.get(user=user)
                except:
                    return self.create_response(request, {
                        'success': False,
                        'reason': 'deprecated',
                    }, HttpForbidden)
                else:
                    return self.create_response(request, {
                        'success': True,
                        'apikey': apikey.key,
                        'username': user.username,
                    })
            else:
                return self.create_response(request, {
                    'success': False,
                    'reason': 'disabled',
                }, HttpForbidden)
        else:
            return self.create_response(request, {
                'success': False,
                'reason': 'incorrect',
            }, HttpUnauthorized)

    def logout(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        if request.user and request.user.is_authenticated():
            auth_logout(request)
            return self.create_response(request, {'success': True})
        else:
            return self.create_response(request, {'success': False}, HttpUnauthorized)
