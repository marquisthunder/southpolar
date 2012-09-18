创建数据库
create database southpolar;
select password('southpolar');
 grant all privileges on southpolar.* to 'southpolar'@'%' identified by password '*6218B161E14BF9A8D811725ABA0B870BE4CE2E68';

./manage.py syncdb
./manage.py runserver

change charset of change_message to utf8 to avoid db broken:
aLTER TABLE django_admin_log MODIFY COLUMN change_message VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
