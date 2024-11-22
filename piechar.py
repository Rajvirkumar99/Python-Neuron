from django.views import View
from django.db.models import Sum
from django.shortcuts import render
from django.db import connection
import pandas as pd 
import numpy as np
from .data import DataHandler
   

def Army_2076(request):  
   
    data_handler = DataHandler()

    # Fetch the data for Army 2076 using army_2076 function
    df= data_handler.army_2076()


    # Define individual army pay calculations using .loc[] instead of .query()
    army_101 = round(df.loc[df['minorhd'] == 101, 'amt'].sum() / 10_000_000, 2)
    army_103 = round(df.loc[df['minorhd'] == 103, 'amt'].sum() / 10_000_000, 2)
    army_104 = round(df.loc[(df['minorhd'] == 104) & (df['ch'] != 23004), 'amt'].sum() / 10_000_000, 2)
    army_106 = round(df.loc[(df['minorhd'] == 106) & df['ch'].isin([35101, 35102, 35103, 35109, 35110, 35111]), 'amt'].sum() / 10_000_000, 2)
    army_107 = round(df.loc[(df['minorhd'] == 107) & (df['sub_head'] == 'A') & df['ch'].isin([36101, 36102, 36103, 36104]), 'amt'].sum() / 10_000_000, 2)
    army_112 = round(df.loc[(df['minorhd'] == 112) & df['ch'].isin([53101, 53102, 53103, 53104, 53105, 53201, 53202, 53301, 53302, 53303, 53304, 53305, 53306, 53307, 53308]), 'amt'].sum() / 10_000_000, 2)
    army_113 = round(df.loc[(df['minorhd'] == 113) & df['sub_head'].isin(['A', 'B', 'G']) & df['ch'].isin([54001, 54002, 54101, 54102, 54103, 54106, 55101, 55102]), 'amt'].sum() / 10_000_000, 2)
    army_114 = round(df.loc[df['minorhd'] == 114, 'amt'].sum() / 10_000_000, 2)


    # Army Store Calculations
    army_store_106 = round(df.loc[(df['minorhd'] == 106) & df['ch'].isin([35105, 35106]), 'amt'].sum() / 10_000_000, 2)
    army_store_107 = round(df.loc[(df['minorhd'] == 107) & df['sub_head'].isin(['C', 'D']), 'amt'].sum() / 10_000_000, 2)
    army_store_110 = round(df.loc[df['minorhd'] == 110, 'amt'].sum() / 10_000_000, 2)
    army_store_112 = round(df.loc[((df['minorhd'] == 112) & df['ch'].between(53601, 53623)) | ((df['minorhd'] == 112) & df['ch'].between(53801, 53810)), 'amt'].sum() / 10_000_000, 2)
    army_store_113 = round(df.loc[(df['minorhd'] == 113) & df['sub_head'].isin(['D', 'H']), 'amt'].sum() / 10_000_000, 2)


    # Miscellaneous Pay Calculations
    army_misc_103 = round(df.loc[(df['minorhd'] == 103) & ~df['ch'].isin([14501, 14502, 14504, 14505, 14601, 14602, 14700, 14800, 14900, 15001, 15002, 15004, 15005, 15006]), 'amt'].sum() / 10_000_000, 2)
    army_misc_107 = round(df.loc[(df['minorhd'] == 107) & (df['ch'].isin([36500, 36600])) & (df['sub_head'] == 'E'), 'amt'].sum() / 10_000_000, 2)
    army_misc_112 = round(df.loc[(df['minorhd'] == 112) & (df['sub_head'] == 'D'), 'amt'].sum() / 10_000_000, 2)
    army_misc_113 = round(df.loc[(df['minorhd'] == 113) & df['ch'].between(55001, 55003), 'amt'].sum() / 10_000_000, 2)
    army_misc_800 = round(df.loc[df['minorhd'] == 800, 'amt'].sum() / 10_000_000, 2)

   
    # Transportation Calculations
    transport_103 = round(df.loc[(df['minorhd'] == 103) & (df['sub_head'] != 'A'), 'amt'].sum() / 10_000_000, 2)
    transport_106 = round(df.loc[(df['minorhd'] == 106) & (df['ch'] == 35107), 'amt'].sum() / 10_000_000, 2)
    transport_112 = round(df.loc[(df['minorhd'] == 112) & df['ch'].isin([53501, 53502]) & (df['sub_head'] == 'E'), 'amt'].sum() / 10_000_000, 2)
    transport_113 = round(df.loc[(df['minorhd'] == 113) & df['ch'].isin([54201, 54202, 54203]) & (df['sub_head'] == 'c'), 'amt'].sum() / 10_000_000, 2)
    transport_105 = round(df.loc[df['minorhd'] == 105, 'amt'].sum() / 10_000_000, 2)

    
    # Army Work Calculations
    army_work_107 = round(df.loc[(df['minorhd'] == 107) & (df['ch'] == 36700) & (df['sub_head'] == 'G'), 'amt'].sum() / 10_000_000, 2)
    army_work_113 = round(df.loc[(df['minorhd'] == 113) & (df['ch'] == 54901) & (df['sub_head'] == 'E'), 'amt'].sum() / 10_000_000, 2)
    army_work_112 = round(df.loc[(df['minorhd'] == 112) & (df['ch'] == 53700) & (df['sub_head'] == 'G'), 'amt'].sum() / 10_000_000, 2)
    army_work_111 = round(df.loc[df['minorhd'] == 111, 'amt'].sum() / 10_000_000, 2)

    # DGQA Work Calculation
    dgqa_work_109 = round(df.loc[(df['minorhd'] == 109) & (df['ch'] == 38501) & (df['sub_head'] == 'F') & (df['RC1'] == 'C'), 'amt'].sum() / 10_000_000, 2)

    
    # Calculate the Total Army
    total_army_pay = round(army_101 + army_103 + army_104 + army_106 + army_107 + army_112 + army_113 + army_114, 2)
    total_store_pay = round(army_store_106 + army_store_107 + army_store_110 + army_store_112 + army_store_113, 2)
    total_miscellaneous_pay = round(army_misc_103 + army_misc_107 + army_misc_112 + army_misc_113 + army_misc_800, 2)
    total_transportation_pay = round(transport_103 + transport_106 + transport_112 + transport_113 + transport_105, 2)
    total_army_work_pay = round(army_work_107 + army_work_113 + army_work_112 + army_work_111 + dgqa_work_109, 2)

    # Combine all results into one dictionary and pass them to the template
    return render(request, 'charts-chartjs.html', {
        'total_army_pay': total_army_pay,
        'total_store_pay': total_store_pay,
        'total_miscellaneous_pay': total_miscellaneous_pay,
        'total_transportation_pay': total_transportation_pay,
        'total_army_work_pay': total_army_work_pay,
    })



def Navy_2077(request):
    pass



def Airforce_2078(request):
    pass




def Airforce_2080(request):
    pass
