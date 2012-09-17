#from django.test import TestCase
#import datetime
from django.contrib.auth.models import User
from tastypie.test import ResourceTestCase
#from member.models import KaasMember


class PortalResourceTest(ResourceTestCase):

    def setUp(self):
        super(PortalResourceTest, self).setUp()
        self.username = 'test'
        self.password = 'test'
        self.api_key = '123456'
        self.user = User.objects.create_user(self.username, 'test@example.com', self.password)
        self.post_data = {
            'username': 'test',
            'password': 'test'
        }

    def get_credentials(self):
        return self.create_basic(username=self.username, password=self.password)

    def get_api_credentials(self):
        return self.create_apikey(username=self.username, api_key=self.api_key)

    def test_post_login(self):
        self.assertHttpOK(self.api_client.post('/api/members/portal/login/', format='json', data=self.post_data, authentication=self.get_credentials()))
