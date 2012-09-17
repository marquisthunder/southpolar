from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin
from member.models import Member
from tastypie.models import ApiAccess
from tastypie.admin import ApiKeyInline

admin.site.register(Member)
admin.site.register(ApiAccess)

class UserModelAdmin(UserAdmin):
        inlines = UserAdmin.inlines + [ApiKeyInline]

admin.site.unregister(User)
admin.site.register(User,UserModelAdmin)
