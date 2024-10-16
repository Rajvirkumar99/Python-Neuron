from django.db.models import Sum
from .models import MasterAll, BudgetData  # Import your models
from django.db import connection
from django.shortcuts import render


from django.db import connection

def get_reports_chart_data(grantno1):
    # SQL query to fetch the top 10 minorhd_desc and amt values for a specific grant
     
    query = '''
        SELECT 
            minorhd_desc, 
            ROUND(SUM(amt) / 10000000, 2) AS amt
        FROM master_all1
        WHERE grantno1 = %s  
          AND RC1 = 'C'
        GROUP BY minorhd, minorhd_desc
        ORDER BY amt DESC
        LIMIT 10;
    '''
    print("Using database:", connection.settings_dict['NAME'])
    # Execute the query and fetch the results
    with connection.cursor() as cursor:
        cursor.execute(query, [grantno1])
        results = cursor.fetchall()

    # Prepare data for the chart
    minorhd_desc = [row[0] for row in results]  # Extract minorhd_desc
    amt = [row[1] for row in results]  # Extract amt

    return minorhd_desc, amt
