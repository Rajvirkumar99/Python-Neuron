from django.db.models import Sum
from django.shortcuts import render
from django.db import connection
from .models import MasterAll,BudgetData


# Create your views here.


def base(request):
    # You can add context data here if needed
    
    return render(request, 'base.html')


# def index(request):
#     # Calculate the sum for 'mod_civil'
#     mod_civil_sum = MasterAll.objects.filter(RC1='c', grantno1=19).aggregate(sum_amt=Sum('AMT'))
#     # Get data from BudgetData
#     budget_summary = BudgetData.objects.aggregate(
#         total_vbe=Sum('vbe'),
#         total_cbe=Sum('cbe')
#     )
#     budget_total_sum = round((budget_summary['total_vbe'] + budget_summary['total_cbe']) / 10000000, 2) if budget_summary['total_vbe'] and budget_summary['total_cbe'] else 0

   

#     mod_civil = round(mod_civil_sum['sum_amt'] / 10000000, 2) if mod_civil_sum['sum_amt'] else 0

#     # Calculate the sum for 'Defence Service Revenue' (DSR)
#     dsr_sum = MasterAll.objects.filter(RC1='c', grantno1=20).aggregate(sum_amt=Sum('AMT'))
#     DSR = round(dsr_sum['sum_amt'] / 10000000, 2) if dsr_sum['sum_amt'] else 0

#     # Calculate the sum for 'Capital Outlay'
#     capitaloutlay_sum = MasterAll.objects.filter(RC1='c', grantno1=21).aggregate(sum_amt=Sum('AMT'))
#     cap_sum = round(capitaloutlay_sum['sum_amt'] / 10000000, 2) if capitaloutlay_sum['sum_amt'] else 0

#     # Calculate the sum for 'Defence Pension Service'
#     defence_pension_sum = MasterAll.objects.filter(RC1='c', grantno1=22).aggregate(sum_amt=Sum('AMT'))
#     dps_sum = round(defence_pension_sum['sum_amt'] / 10000000, 2) if defence_pension_sum['sum_amt'] else 0

#     # Create a single context dictionary with all values
#     context = {
          
#         'mod_civil': mod_civil,
#         'dsr': DSR,
#         'cap_sum': cap_sum,
#         'dps_sum': dps_sum,  
#         'summary': budget_total_sum,
#     }

#     return render(request, 'index.html', context)


# views.py
from django.shortcuts import render
from .models import MasterAll  # Import your models if not already imported
from .bud_exp_calcul import calculate_budget_summary, calculate_sum_for_grant,budget_ongrantlevel
def index(request):
    # Use the imported function to get the budget summary
    budget_total_sum = calculate_budget_summary()

     # Get the budget sum at the grant level using the raw SQL function
    # grant_level_budget = budget_ongrantlevel()

    grant_level_budget =budget_ongrantlevel([2014, 2037, 2052, 2059, 2075, 2216, 2852, 4047, 4059, 4070, 4216, 7615])
    # Use the imported function to calculate sums for specific grants
    mod_civil = calculate_sum_for_grant('c', 19)  # 'mod_civil' sum
    DSR = calculate_sum_for_grant('c', 20)        # 'Defence Service Revenue' sum
    cap_sum = calculate_sum_for_grant('c', 21)    # 'Capital Outlay' sum
    dps_sum = calculate_sum_for_grant('c', 22)    # 'Defence Pension Service' sum

    # Create a single context dictionary with all values
    context = {
        'mod_civil': mod_civil,
        'dsr': DSR,
        'cap_sum': cap_sum,
        'dps_sum': dps_sum,
        'summary': budget_total_sum,
        'grant_level_budget': grant_level_budget 
    }

    return render(request, 'index.html', context)









from django.db.models import Sum
from .models import MasterAll

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
























































