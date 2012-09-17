create database kaasfront
./manage.py syncdb
./manage.py runserver

change charset of change_message to utf8 to avoid db broken:
ALTER TABLE django_admin_log MODIFY COLUMN change_message VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
