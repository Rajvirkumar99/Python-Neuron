# bud&Expcalcul.py
from django.db.models import Sum
from .models import MasterAll, BudgetData  # Import your models
from django.db import connection
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



# def budget_ongrantlevel():
#     # Using raw SQL query to calculate the sum
#     query = """
#     SELECT ROUND(SUM(vbe) + SUM(cbe) / 10000000, 2) AS total_sum 
#     FROM bud_majhd2425 
#     WHERE budmajhdid IN (2014, 2037, 2052, 2059, 2075, 2216, 2852, 4047, 4059, 4070, 4216, 7615)
#     """
#     with connection.cursor() as cursor:
#         cursor.execute(query)
#         result = cursor.fetchone()
    
#     # Return the calculated sum value, result[0] will fetch the value of total_sum
#     return result[0] if result else 0


def budget_ongrantlevel(budmajhdid_list):
    """
    Calculate the sum dynamically using raw SQL based on a list of budmajhdid values.
    """
    # Convert the list of budmajhdid values into a string format for the SQL IN clause
    budmajhdid_str = ', '.join(map(str, budmajhdid_list))

    # Using raw SQL query with dynamic budmajhdid values
    query = f"""
    SELECT ROUND(SUM(vbe) + SUM(cbe) / 10000000, 2) AS total_sum 
    FROM bud_majhd2425 
    WHERE budmajhdid IN ({budmajhdid_str})
    """
    
    # Execute the SQL query and fetch the result
    with connection.cursor() as cursor:
        cursor.execute(query)
        result = cursor.fetchone()

    # Return the calculated sum value
    return result[0] if result else 0







