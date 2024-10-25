from django.contrib import admin
from django.urls import path
from misreport import views  # Corrected import statement

urlpatterns = [
    path('admin/', admin.site.urls),
  
    path('', views.index, name='index'),

    path('extract-data/', views.extract_data_view, name='extract_data'),  # URL pattern for the extract data view


    # path('extract-data/', views.extract_data_view, name='extract_data'),  # URL pattern for the extract data view
    path('chart', views.linechart, name='chart-js'),
    path('userprofile', views.userprofile, name='userprofile'),
    path('pageregister', views.pageregister, name='pageregister'),
    path('loginpage', views.loginpage, name='loginpage'),
]






