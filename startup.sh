pip install django
gunicorn /home/site/wwwroot/VulnerableAzure/VulnerableAzure.wsgi --bind=0.0.0.0:80
