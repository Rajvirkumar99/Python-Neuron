from django.contrib import admin
from django.urls import path
from misreport import views  # Corrected import statement
from misreport.views import  pageregister
from misreport.piechart import Army_2076


urlpatterns = [
    path('admin/', admin.site.urls),
  
    path('', views.index, name='index'),

    path('extract-data/', views.extract_data_view, name='extract_data'),  # URL pattern for the extract data view


    path('extract-data/', views.extract_data_view, name='extract_data'),  # URL pattern for the extract data view
    path('chart', views.linechart, name='chart-js'),
    path('userprofile', views.userprofile, name='userprofile'),
    path('pageregister/', pageregister, name='pageregister'),

    path('loginpage', views.loginpage, name='loginpage'),

    # path('army_2076', piechart.Army_2076, name='army_2076'),
   
]






