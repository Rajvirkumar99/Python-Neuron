# data.py
import pandas as pd
from django.db import connection
from django.db.models import Sum
from .models import MasterAll  # Ensure MasterAll is correctly imported from your models

class DataHandler:
    def __init__(self):
        pass

    def army_2076(self):
        """Handles the SQL query for Army 2076."""
        query = """
            SELECT majhd, minorhd, RC1, AMT AS amt, ch, sub_head
            FROM master_all1
            WHERE majhd = 2076 AND RC1 = 'C'
        """
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [col[0] for col in cursor.description]
            data = cursor.fetchall()

        # Convert the result to a DataFrame
        df = pd.DataFrame(data, columns=columns)
        return df

    def calculate_sum_for_grant(self, rc1, grantno):
        """Calculates the sum for a specific grant."""
        sum_result = MasterAll.objects.filter(RC1=rc1, grantno1=grantno).aggregate(sum_amt=Sum('AMT'))
        calculated_sum = round(sum_result['sum_amt'] / 10000000, 2) if sum_result['sum_amt'] else 0
        return calculated_sum

    def calculate_army_101(self):
        """Filters data for Army 2076 and minorhd 101."""
        # Load data from Django model into a DataFrame
        queryset = MasterAll.objects.all().values()
        master_all = pd.DataFrame.from_records(queryset)
        
        # Filter the DataFrame for specific criteria
        filtered_df = master_all[(master_all['majhd'] == 2076) & 
                                 (master_all['minorhd'] == 101) & 
                                 (master_all['RC1'] == 'C')]
        return filtered_df
