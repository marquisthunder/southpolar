from django.contrib.auth.models import User
from tastypie.resources import ModelResource
from tastypie import fields
from member.models import Member
from tastypie.authentication import ApiKeyAuthentication


class UserResource(ModelResource):

    class Meta:
        queryset = User.objects.all()
        resource_name = 'profile'
        authentication = ApiKeyAuthentication()
        fields = ['username', 'first_name', 'last_name', 'last_login']
        allowed_methods = ['get', 'post']


class MemberResource(ModelResource):
    user = fields.ForeignKey(UserResource, 'user')

    class Meta:
        queryset = Member.objects.all()
        resource_name = "member"
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get', 'post']

    def dehydrate(self, bundle):
        return bundle
