#Settings specific for development environment

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'django_lvp',                      # Or path to database file if using sqlite3.
        'USER': 'django_lvp',                      # Not used with sqlite3.
        'PASSWORD': 'godjan',                  # Not used with sqlite3.
        'HOST': '134.121.166.73',                      # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '',                      # Set to empty string for default. Not used with sqlite3.
    }
}

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    'C:/django/library_value/templates',
)
