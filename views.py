from .data import DataHandler
from django.views import View
from django.db.models import Sum
from django.shortcuts import render
from django.db import connection
from .models import MasterAll,BudgetData,UserDetails
from .chart import get_reports_chart_data
from django.shortcuts import render
from .models import MasterAll  # Import your models if not already imported
from  .bud_exp_calcul import calculate_budget_summary, calculate_sum_for_grant,budget_ongrantlevel,total_budget_and_expenditure,grantwisepercentage

import pandas as pd 


# Create your views here.


def base(request):
    # You can add context data here if needed
    
    return render(request, 'base.html')


def index(request):
    # Use the imported function to get the budget summary
    budget_total_sum = calculate_budget_summary()

    # Calling the function and printing the result grantwisee budget
    mod_civil_bud = budget_ongrantlevel([2014, 2037, 2052, 2059, 2075, 2216, 2852, 4047, 4059, 4070, 4216, 7615])
    Defence_service_revenue_bud = budget_ongrantlevel([2076,2077, 2078,2079,2080])
    capital_Outlay_bud = budget_ongrantlevel([4076])
    defence_pensions_bud = budget_ongrantlevel([2071])
  

    defence_budget=mod_civil_bud+Defence_service_revenue_bud+capital_Outlay_bud+defence_pensions_bud
  
    # Use the imported function to calculate sums for specific grants
    mod_civil = calculate_sum_for_grant('c', 19)  # 'mod_civil' sum
    DSR = calculate_sum_for_grant('c', 20)        # 'Defence Service Revenue' sum
    cap_sum = calculate_sum_for_grant('c', 21)    # 'Capital Outlay' sum
    dps_sum = calculate_sum_for_grant('c', 22)    # 'Defence Pension Service' sum
    
    defenceexp=mod_civil+DSR+cap_sum+dps_sum


    # Get total expenditure and percentage from total_budget_and_expenditure function
    total_expenditure, expenditure_percentage = total_budget_and_expenditure()


    # Get chart data for multiple grants
    minorhd_desc_19, amt_19 = get_reports_chart_data(19)
    minorhd_desc_20, amt_20 = get_reports_chart_data(20)
    minorhd_desc_21, amt_21 = get_reports_chart_data(21)
    minorhd_desc_22, amt_22 = get_reports_chart_data(22)


    # Calculate grantwise percentage
    grantwise_exp = grantwisepercentage()

    # Extract individual percentages from grantwise_exp
    mod_civil_pct = grantwise_exp["mod_civil_pct"]
    DSR_pct = grantwise_exp["DSR_pct"]
    capital_Outlay_pct = grantwise_exp["capital_Outlay_pct"]
    defence_pensions_pct = grantwise_exp["defence_pensions_pct"]

    # Create a single context dictionary with all values
    context = {
        'mod_civil': mod_civil,
        'dsr': DSR,
        'cap_sum': cap_sum,
        'dps_sum': dps_sum,
        'summary': budget_total_sum,
        'mod_civil_bud': mod_civil_bud ,
        'Defence_service_revenue_bud':Defence_service_revenue_bud,
        'capital_Outlay_bud': capital_Outlay_bud,
        'defence_pensions_bud':defence_pensions_bud,
        'Total_Defence_Expenditure':defenceexp,
        'Total_deefence_budget':defence_budget,
        # Chart data for multiple grants
        'minorhd_desc_19': minorhd_desc_19,
        'amt_19': amt_19,
        'minorhd_desc_20': minorhd_desc_20,
        'amt_20': amt_20,
        'minorhd_desc_21': minorhd_desc_21,
        'amt_21': amt_21,
        'minorhd_desc_22': minorhd_desc_22,
        'amt_22': amt_22,
        'total_expenditure': total_expenditure,  # Pass total expenditure
        'expenditure_percentage': expenditure_percentage,  # Pass expenditure percentage

         # Grantwise expenditure percentages
        'mod_civil_pct': mod_civil_pct,
        'DSR_pct': DSR_pct,
        'capital_Outlay_pct': capital_Outlay_pct,
        'defence_pensions_pct': defence_pensions_pct,

  

    }

    return render(request, 'index.html', context)




#----------------------------------------------------------------


def extract_data_view(request):
    # Calculate the sum for `mod_civil` based on filters
    mod_civil_sum = MasterAll.objects.filter(RC1='c', grantno1=19).aggregate(sum_amt=Sum('AMT'))
    mod_civil = round(mod_civil_sum['sum_amt'] / 10000000, 2) if mod_civil_sum['sum_amt'] else 0

    # Calculate the sum for `DSR` based on a different grant number
    dsr_sum = MasterAll.objects.filter(RC1='c', grantno1=20).aggregate(sum_amt=Sum('AMT'))
    DSR = round(dsr_sum['sum_amt'] / 10000000, 2) if dsr_sum['sum_amt'] else 0

    # Merge both into a single context dictionary
    context = {
        'data': MasterAll.objects.filter(RC1='c', grantno1=19),
        'mod_civil': mod_civil,
        'dsr': DSR,  # Include DSR in the same context dictionary
    }

    return render(request, 'index.html', context)



# This For testing all graph data in piechart
def linechart(request):
      # Create an instance of DataHandler class to fetch data
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

    # Calculate total pay by adding all the individual army pays
    total_army_pay = round(army_101 + army_103 + army_104 + army_106 + army_107 + army_112 + army_113 + army_114, 2)

    # Army Store Calculations
    army_store_106 = round(df.loc[(df['minorhd'] == 106) & df['ch'].isin([35105, 35106]), 'amt'].sum() / 10_000_000, 2)
    army_store_107 = round(df.loc[(df['minorhd'] == 107) & df['sub_head'].isin(['C', 'D']), 'amt'].sum() / 10_000_000, 2)
    army_store_110 = round(df.loc[df['minorhd'] == 110, 'amt'].sum() / 10_000_000, 2)
    army_store_112 = round(df.loc[((df['minorhd'] == 112) & df['ch'].between(53601, 53623)) | ((df['minorhd'] == 112) & df['ch'].between(53801, 53810)), 'amt'].sum() / 10_000_000, 2)
    army_store_113 = round(df.loc[(df['minorhd'] == 113) & df['sub_head'].isin(['D', 'H']), 'amt'].sum() / 10_000_000, 2)

    # Calculate total store pay by adding up all the individual stores
    total_store_pay = round(army_store_106 + army_store_107 + army_store_110 + army_store_112 + army_store_113, 2)

    # Miscellaneous Pay Calculations
    army_misc_103 = round(df.loc[(df['minorhd'] == 103) & ~df['ch'].isin([14501, 14502, 14504, 14505, 14601, 14602, 14700, 14800, 14900, 15001, 15002, 15004, 15005, 15006]), 'amt'].sum() / 10_000_000, 2)
    army_misc_107 = round(df.loc[(df['minorhd'] == 107) & (df['ch'].isin([36500, 36600])) & (df['sub_head'] == 'E'), 'amt'].sum() / 10_000_000, 2)
    army_misc_112 = round(df.loc[(df['minorhd'] == 112) & (df['sub_head'] == 'D'), 'amt'].sum() / 10_000_000, 2)
    army_misc_113 = round(df.loc[(df['minorhd'] == 113) & df['ch'].between(55001, 55003), 'amt'].sum() / 10_000_000, 2)
    army_misc_800 = round(df.loc[df['minorhd'] == 800, 'amt'].sum() / 10_000_000, 2)

    # Calculate total miscellaneous pay
    total_miscellaneous_pay = round(army_misc_103 + army_misc_107 + army_misc_112 + army_misc_113 + army_misc_800, 2)

    # Transportation Calculations
    transport_103 = round(df.loc[(df['minorhd'] == 103) & (df['sub_head'] != 'A'), 'amt'].sum() / 10_000_000, 2)
    transport_106 = round(df.loc[(df['minorhd'] == 106) & (df['ch'] == 35107), 'amt'].sum() / 10_000_000, 2)
    transport_112 = round(df.loc[(df['minorhd'] == 112) & df['ch'].isin([53501, 53502]) & (df['sub_head'] == 'E'), 'amt'].sum() / 10_000_000, 2)
    transport_113 = round(df.loc[(df['minorhd'] == 113) & df['ch'].isin([54201, 54202, 54203]) & (df['sub_head'] == 'c'), 'amt'].sum() / 10_000_000, 2)
    transport_105 = round(df.loc[df['minorhd'] == 105, 'amt'].sum() / 10_000_000, 2)

    # Calculate total transportation pay
    total_transportation_pay = round(transport_103 + transport_106 + transport_112 + transport_113 + transport_105, 2)

    # Army Work Calculations
    army_work_107 = round(df.loc[(df['minorhd'] == 107) & (df['ch'] == 36700) & (df['sub_head'] == 'G'), 'amt'].sum() / 10_000_000, 2)
    army_work_113 = round(df.loc[(df['minorhd'] == 113) & (df['ch'] == 54901) & (df['sub_head'] == 'E'), 'amt'].sum() / 10_000_000, 2)
    army_work_112 = round(df.loc[(df['minorhd'] == 112) & (df['ch'] == 53700) & (df['sub_head'] == 'G'), 'amt'].sum() / 10_000_000, 2)
    army_work_111 = round(df.loc[df['minorhd'] == 111, 'amt'].sum() / 10_000_000, 2)

    # DGQA Work Calculation
    dgqa_work_109 = round(df.loc[(df['minorhd'] == 109) & (df['ch'] == 38501) & (df['sub_head'] == 'F') & (df['RC1'] == 'C'), 'amt'].sum() / 10_000_000, 2)

    # Total Army Work Pay Calculation
    total_army_work_pay = round(army_work_107 + army_work_113 + army_work_112 + army_work_111 + dgqa_work_109, 2)

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




# user profile 
def userprofile(request):
    print("Rendering user-profile.html")  
    return render(request, 'users-profile.html')



#Register page  for login

from django.contrib.auth.hashers import make_password
def pageregister(request):
    if request.method == 'POST':
        # Handle form submission
        name = request.POST.get('name')
        email = request.POST.get('email')
        designation = request.POST.get('designation')
        phone = request.POST.get('phone')
        office_name = request.POST.get('office_name')
        purpose = request.POST.get('purpose')
        register_date = request.POST.get('date')
        username = request.POST.get('username')
        password = request.POST.get('password')

          #Create a new user instance
        user = UserDetails(
            username=username,
            password=make_password(password),  # Hash the password
            designation=designation,
            phone=phone,
            office_name=office_name,
            purpose=purpose,
            register_date=register_date,
        )
        
        # Save the user instance to the database
        user.save()

     

    # If GET request, render the registration form
    return render(request, 'pages-register.html')





#login Page
def loginpage(request):
    print("Rendering pages-login.html") 
    return render(request, 'pages-login.html')





















































