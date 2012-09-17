#from django.test import TestCase
#import datetime
from django.contrib.auth.models import User
from tastypie.test import ResourceTestCase
#from member.models import KaasMember

class MembersResourceTest(ResourceTestCase):
    def setUp(self):
        super(MembersResourceTest, self).setUp()
        self.username = 'test'
        self.password = 'test'
        self.api_key = '123456'
        self.user = User.objects.create_user(self.username, 'test@example.com', self.password)
        self.post_data = {
                'user': '/api/v1/user/{0}/'.format(self.user.pk),
                'title': 'Second Post!',
                'slug': 'second-post',
                'created': '2012-05-01T22:05:12'
        }
        #self.member =
    def get_credentials(self):
        return self.create_basic(username=self.username, password=self.password)
    def get_api_credentials(self):
        return self.create_apikey(username=self.username, api_key=self.api_key)
    def test_get_members(self):
        resp = self.api_client.get('/api/members/', format='json', authentication=self.get_api_credentials())
        self.assertValidJSONResponse(resp)
    def test_get_members_member(self):
        resp = self.api_client.get('/api/members/member/', format='json', authentication=self.get_api_credentials())
        self.assertValidJSONResponse(resp)
    def test_get_members_profile(self):
        resp = self.api_client.get('/api/members/profile/', format='json', authentication=self.get_api_credentials())
        self.assertValidJSONResponse(resp)

