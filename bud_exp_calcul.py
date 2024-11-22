# bud&Expcalcul.py
from django.db.models import Sum
from .models import MasterAll, BudgetData  # Import your models
from django.db import connection
from decimal import Decimal
import numpy as np
import pandas as pd

# Function to calculate budget summary
def calculate_budget_summary():
    budget_summary = BudgetData.objects.aggregate(
        total_vbe=Sum('vbe'),
        total_cbe=Sum('cbe')
    )
    budget_total_sum = round((budget_summary['total_vbe'] + budget_summary['total_cbe']) / 10000000, 2) if budget_summary['total_vbe'] and budget_summary['total_cbe'] else 0
    return budget_total_sum

# Function to calculate sum for a given RC1 and grant number
def calculate_sum_for_grant(rc1, grantno):
    sum_result = MasterAll.objects.filter(RC1=rc1, grantno1=grantno).aggregate(sum_amt=Sum('AMT'))
    calculated_sum = round(sum_result['sum_amt'] / 10000000, 2) if sum_result['sum_amt'] else 0
    return calculated_sum


# Its require in furture 

# def budget_ongrantlevel(budmajhdid_list):
#     """
#     Calculate the sum dynamically using raw SQL based on a list of budmajhdid values.
#     """
#     # Convert the list of budmajhdid values into a string format for the SQL IN clause
#     budmajhdid_str = ', '.join(map(str, budmajhdid_list))

#     # Using raw SQL query with dynamic budmajhdid values
#     query = f"""
#     SELECT ROUND((SUM(vbe) + SUM(cbe)) / 10000, 2) AS total_sum 
#     FROM bud_majhd2425 
#     WHERE budmajhdid IN ({budmajhdid_str})
#     """

#     # Execute the SQL query and fetch the result
#     with connection.cursor() as cursor:
#         cursor.execute(query)
#         result = cursor.fetchone()

#     # Return the calculated sum value
#     return result[0] if result else 0



def budget_ongrantlevel(budmajhdid_list):
    """
    Calculate the sum dynamically using raw SQL based on a list of budmajhdid values.
    If one set of columns has no data, check the next set.
    """
    # Convert the list of budmajhdid values into a string format for the SQL IN clause
    budmajhdid_str = ', '.join(map(str, budmajhdid_list))

    # Check for data availability in each column set
    column_sets = [
        ('vbe', 'cbe'),
        ('vre', 'cre'),
        ('vma', 'cma')
    ]

    for col1, col2 in column_sets:
        # Construct the query to check for data presence in the current column set
        check_query = f"""
        SELECT COUNT(*) 
        FROM bud_majhd2425 
        WHERE {col1} IS NOT NULL OR {col2} IS NOT NULL AND budmajhdid IN ({budmajhdid_str})
        """

        # Execute the check query
        with connection.cursor() as cursor:
            cursor.execute(check_query)
            data_present = cursor.fetchone()[0]

        # If data is found in the current set of columns, calculate the sum
        if data_present:
            query = f"""
            SELECT ROUND((SUM({col1}) + SUM({col2})) / 10000, 2) AS total_sum 
            FROM bud_majhd2425 
            WHERE budmajhdid IN ({budmajhdid_str})
            """
            with connection.cursor() as cursor:
                cursor.execute(query)
                result = cursor.fetchone()
            return result[0] if result else 0

    # If no data is found in any set of columns, return 0
    return 0





def total_budget_and_expenditure():
     # Calculate expenditure from different grants
    mod_civil = calculate_sum_for_grant('c', 19)  # 'mod_civil' sum
    DSR = calculate_sum_for_grant('c', 20)        # 'Defence Service Revenue' sum
    cap_sum = calculate_sum_for_grant('c', 21)    # 'Capital Outlay' sum
    dps_sum = calculate_sum_for_grant('c', 22) 
    # Total expenditure
    defenceexp = mod_civil + DSR + cap_sum + dps_sum
    # Calculate budget from different grants
    mod_civil_bud = budget_ongrantlevel([2014, 2037, 2052, 2059, 2075, 2216, 2852, 4047, 4059, 4070, 4216, 7615])
    Defence_service_revenue_bud = budget_ongrantlevel([2076, 2077, 2078, 2079, 2080])
    capital_Outlay_bud = budget_ongrantlevel([4076])
    defence_pensions_bud = budget_ongrantlevel([2071])




    # Total defence budget
    defence_budget = (mod_civil_bud + Defence_service_revenue_bud + 
                      capital_Outlay_bud + defence_pensions_bud)

    # Convert to float if necessary for the percentage calculation
    if isinstance(defenceexp, Decimal):
        defenceexp = float(defenceexp)

    if isinstance(defence_budget, Decimal):
        defence_budget = float(defence_budget)

    # Calculate expenditure percentage, ensuring no division by zero
    if defence_budget > 0:
        expenditure_percentage = round((defenceexp / defence_budget) * 100, 2)
    else:
        expenditure_percentage = 0.0  # Handle as needed

    return defenceexp, expenditure_percentage


# def grantwisepercentage():
#     # Calculate expenditure from different grants
#     mod_civil = calculate_sum_for_grant('c', 19)  # 'mod_civil' sum
#     DSR = calculate_sum_for_grant('c', 20)        # 'Defence Service Revenue' sum
#     cap_sum = calculate_sum_for_grant('c', 21)    # 'Capital Outlay' sum
#     dps_sum = calculate_sum_for_grant('c', 22)    # 'Defence Pensions' sum

#     # Calculate budget from different grants
#     mod_civil_bud = budget_ongrantlevel([2014, 2037, 2052, 2059, 2075, 2216, 2852, 4047, 4059, 4070, 4216, 7615])
#     Defence_service_revenue_bud = budget_ongrantlevel([2076, 2077, 2078, 2079, 2080])
#     capital_Outlay_bud = budget_ongrantlevel([4076])
#     defence_pensions_bud = budget_ongrantlevel([2071])

#     # Avoid division by zero and calculate percentages rounded to 2 decimal places
#     mod_civil_pct = round((mod_civil / mod_civil_bud) * 100, 2) if mod_civil_bud != 0 else 0.0
#     DSR_pct = round((DSR / Defence_service_revenue_bud) * 100, 2) if Defence_service_revenue_bud != 0 else 0.0
#     capital_Outlay_pct = round((cap_sum / capital_Outlay_bud) * 100, 2) if capital_Outlay_bud != 0 else 0.0
#     defence_pensions_pct = round((dps_sum / defence_pensions_bud) * 100, 2) if defence_pensions_bud != 0 else 0.0

#     # Return the results in a dictionary
#     print("mod_civil_pct",mod_civil_pct)
#     print("DSR_pct",DSR_pct)
#     print("capital_Outlay_pct",capital_Outlay_pct)
#     print("defence_pensions_pct",defence_pensions_pct)
#     return {
#         "mod_civil_pct": mod_civil_pct,
#         "DSR_pct": DSR_pct,
#         "capital_Outlay_pct": capital_Outlay_pct,
#         "defence_pensions_pct": defence_pensions_pct
#     }



# ---------------------------------------------------------------


import sys

def grantwisepercentage():
    # Calculate expenditure from different grants
    mod_civil = calculate_sum_for_grant('c', 19)  # 'mod_civil' sum
    DSR = calculate_sum_for_grant('c', 20)        # 'Defence Service Revenue' sum
    cap_sum = calculate_sum_for_grant('c', 21)    # 'Capital Outlay' sum
    dps_sum = calculate_sum_for_grant('c', 22)    # 'Defence Pensions' sum

    # Calculate budget from different grants
    mod_civil_bud = budget_ongrantlevel([2014, 2037, 2052, 2059, 2075, 2216, 2852, 4047, 4059, 4070, 4216, 7615])
    Defence_service_revenue_bud = budget_ongrantlevel([2076, 2077, 2078, 2079, 2080])
    capital_Outlay_bud = budget_ongrantlevel([4076])
    defence_pensions_bud = budget_ongrantlevel([2071])

    # Avoid division by zero and calculate percentages rounded to 2 decimal places
    mod_civil_pct = round((mod_civil / mod_civil_bud) * 100, 2) if mod_civil_bud != 0 else 0.0
    # print("mod_civil_pct:", mod_civil_pct)

    DSR_pct = round((DSR / Defence_service_revenue_bud) * 100, 2) if Defence_service_revenue_bud != 0 else 0.0
    capital_Outlay_pct = round((cap_sum / capital_Outlay_bud) * 100, 2) if capital_Outlay_bud != 0 else 0.0
    defence_pensions_pct = round((dps_sum / defence_pensions_bud) * 100, 2) if defence_pensions_bud != 0 else 0.0

   
    
    # sys.stdout.flush()  # Ensure immediate output in terminal
    # print("DSR_pct:", DSR_pct)
    # sys.stdout.flush()  # Ensure immediate output in terminal
    # print("capital_Outlay_pct:", capital_Outlay_pct)
    # sys.stdout.flush()  # Ensure immediate output in terminal
    # print("defence_pensions_pct:", defence_pensions_pct)
    # sys.stdout.flush()  # Ensure immediate output in terminal

    return {
        "mod_civil_pct": mod_civil_pct,
        "DSR_pct": DSR_pct,
        "capital_Outlay_pct": capital_Outlay_pct,
        "defence_pensions_pct": defence_pensions_pct
    }


# your_app/views.py
from django.shortcuts import render
import pandas as pd
from  misreport.models import MasterAll

def calculate_army_101(request):
    # Load data from Django model into a DataFrame
    queryset = MasterAll.objects.all().values()
    master_all = pd.DataFrame.from_records(queryset)
    
    # Filter the rows where 'majhd' is 2076, 'minorhd' is 101, and 'RC1' is 'C'
    filtered_df = master_all[(master_all['majhd'] == 2076) & 
                             (master_all['minorhd'] == 101) & 
                             (master_all['RC1'] == 'C')]
    
    # Calculate the sum of 'amt' for the filtered rows, divide by 10,000,000, and round to 2 decimal places
    army_101 = round(filtered_df['amt'].sum() / 10000000, 2)
    print ( 'calculate_template.html', {'army_101': army_101})
    
    # Render the result in the template
    return render(request, 'calculate_template.html', {'army_101': army_101})





