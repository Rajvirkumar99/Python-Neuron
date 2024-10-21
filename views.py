from django.db.models import Sum
from django.shortcuts import render
from django.db import connection
from .models import MasterAll,BudgetData
from .chart import get_reports_chart_data
from django.shortcuts import render
from .models import MasterAll  # Import your models if not already imported
from  .bud_exp_calcul import calculate_budget_summary, calculate_sum_for_grant,budget_ongrantlevel,total_budget_and_expenditure,grantwisepercentage


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
        'defence_pensions_pct': defence_pensions_pct
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


def linechart(request):
    # Calculate the sum for 'mod_civil'
   

    return render(request, 'charts-chartjs.html')
























































