

```python
# Import dependencies
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import datetime
from datetime import date
from datetime import time
from datetime import datetime
#import calendar
import warnings
warnings.filterwarnings('ignore')
import io
```


```python
# https://nikgrozev.com/2015/06/16/fast-and-simple-sampling-in-pandas-when-loading-data-from-files/
# Fast and Simple Sampling in Pandas when Loading Data From Files
# The data to load
p = "Resources/LA_Parking.csv"

# Take every N-th (in this case 10th) row
n = 10

# Count the lines or use an upper bound
num_lines = sum(1 for l in open(p))

# The row indices to skip - make sure 0 is not included to keep the header!
skip_idx = [x for x in range(1, num_lines) if x % n != 0]

# Read the data
la_parking_df = pd.read_csv(p, skiprows=skip_idx)
la_parking_df.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Ticket number</th>
      <th>Issue Date</th>
      <th>Issue time</th>
      <th>Meter Id</th>
      <th>Marked Time</th>
      <th>RP State Plate</th>
      <th>Plate Expiry Date</th>
      <th>VIN</th>
      <th>Make</th>
      <th>Body Style</th>
      <th>Color</th>
      <th>Location</th>
      <th>Route</th>
      <th>Agency</th>
      <th>Violation code</th>
      <th>Violation Description</th>
      <th>Fine amount</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1121041762</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>955.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201807.0</td>
      <td>NaN</td>
      <td>KIA</td>
      <td>PA</td>
      <td>RE</td>
      <td>1048 E 43RD ST</td>
      <td>13A27</td>
      <td>1</td>
      <td>8056E4</td>
      <td>RED ZONE</td>
      <td>93.0</td>
      <td>6.483814e+06</td>
      <td>1.824574e+06</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4324502346</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>1134.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201706.0</td>
      <td>NaN</td>
      <td>GMC</td>
      <td>TK</td>
      <td>BL</td>
      <td>16900 VERMONT AVE S</td>
      <td>00500</td>
      <td>55</td>
      <td>5204A-</td>
      <td>DISPLAY OF TABS</td>
      <td>25.0</td>
      <td>9.999900e+04</td>
      <td>9.999900e+04</td>
    </tr>
  </tbody>
</table>
</div>




```python
print(f"Parking number of rows = {la_parking_df['Ticket number'].count()}")
```

    Parking number of rows = 199879
    


```python
# Separate Date column by day, month and year and the complete date without the hours
```


```python
la_parking_df['Year'] = [i[0:4] for i in la_parking_df['Issue Date']]
```


```python
la_parking_df['Month'] = [i[5:7] for i in la_parking_df['Issue Date']]
```


```python
la_parking_df['Day'] = [i[8:10] for i in la_parking_df['Issue Date']]
```


```python
la_parking_df['Parking_Date'] = [i[0:10] for i in la_parking_df['Issue Date']]
```


```python
la_parking_df.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Ticket number</th>
      <th>Issue Date</th>
      <th>Issue time</th>
      <th>Meter Id</th>
      <th>Marked Time</th>
      <th>RP State Plate</th>
      <th>Plate Expiry Date</th>
      <th>VIN</th>
      <th>Make</th>
      <th>Body Style</th>
      <th>...</th>
      <th>Agency</th>
      <th>Violation code</th>
      <th>Violation Description</th>
      <th>Fine amount</th>
      <th>Latitude</th>
      <th>Longitude</th>
      <th>Year</th>
      <th>Month</th>
      <th>Day</th>
      <th>Parking_Date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1121041762</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>955.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201807.0</td>
      <td>NaN</td>
      <td>KIA</td>
      <td>PA</td>
      <td>...</td>
      <td>1</td>
      <td>8056E4</td>
      <td>RED ZONE</td>
      <td>93.0</td>
      <td>6.483814e+06</td>
      <td>1.824574e+06</td>
      <td>2018</td>
      <td>01</td>
      <td>01</td>
      <td>2018/01/01</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4324502346</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>1134.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201706.0</td>
      <td>NaN</td>
      <td>GMC</td>
      <td>TK</td>
      <td>...</td>
      <td>55</td>
      <td>5204A-</td>
      <td>DISPLAY OF TABS</td>
      <td>25.0</td>
      <td>9.999900e+04</td>
      <td>9.999900e+04</td>
      <td>2018</td>
      <td>01</td>
      <td>01</td>
      <td>2018/01/01</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 23 columns</p>
</div>




```python
la_parking_df.columns
```




    Index(['Ticket number', 'Issue Date', 'Issue time', 'Meter Id', 'Marked Time',
           'RP State Plate', 'Plate Expiry Date', 'VIN', 'Make', 'Body Style',
           'Color', 'Location', 'Route', 'Agency', 'Violation code',
           'Violation Description', 'Fine amount', 'Latitude', 'Longitude', 'Year',
           'Month', 'Day', 'Parking_Date'],
          dtype='object')




```python
# select columns to use for the project
la_parking_df_project = la_parking_df[['Ticket number', 'Issue Date', 'Issue time', 'Meter Id', 'Marked Time',
       'RP State Plate', 'Plate Expiry Date', 'VIN', 'Make', 'Body Style',
       'Color', 'Location', 'Route', 'Agency', 'Violation code',
       'Violation Description', 'Fine amount', 'Latitude', 'Longitude', 'Year',
       'Month', 'Day', 'Parking_Date']]
```


```python
la_parking_df_project.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Ticket number</th>
      <th>Issue Date</th>
      <th>Issue time</th>
      <th>Meter Id</th>
      <th>Marked Time</th>
      <th>RP State Plate</th>
      <th>Plate Expiry Date</th>
      <th>VIN</th>
      <th>Make</th>
      <th>Body Style</th>
      <th>...</th>
      <th>Agency</th>
      <th>Violation code</th>
      <th>Violation Description</th>
      <th>Fine amount</th>
      <th>Latitude</th>
      <th>Longitude</th>
      <th>Year</th>
      <th>Month</th>
      <th>Day</th>
      <th>Parking_Date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1121041762</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>955.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201807.0</td>
      <td>NaN</td>
      <td>KIA</td>
      <td>PA</td>
      <td>...</td>
      <td>1</td>
      <td>8056E4</td>
      <td>RED ZONE</td>
      <td>93.0</td>
      <td>6.483814e+06</td>
      <td>1.824574e+06</td>
      <td>2018</td>
      <td>01</td>
      <td>01</td>
      <td>2018/01/01</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4324502346</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>1134.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201706.0</td>
      <td>NaN</td>
      <td>GMC</td>
      <td>TK</td>
      <td>...</td>
      <td>55</td>
      <td>5204A-</td>
      <td>DISPLAY OF TABS</td>
      <td>25.0</td>
      <td>9.999900e+04</td>
      <td>9.999900e+04</td>
      <td>2018</td>
      <td>01</td>
      <td>01</td>
      <td>2018/01/01</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 23 columns</p>
</div>




```python
# save df to a csv file
la_parking_df_project.to_csv(r'Resources\la_parking_df_project.csv')
```

###  Connect to local database


```python
### Connect to local database
rds_connection_string = "root:modelobootcamp@127.0.0.1/ladata_db"
engine = create_engine(f'mysql://{rds_connection_string}')
connection = engine.connect()
```


```python
# 7
# 6 of 11 crimes
connection.execute('use ladata_db;')
```




    <sqlalchemy.engine.result.ResultProxy at 0x2424c4e7780>




```python
# 8
# 7 of 11 crimes
engine.table_names()
```




    ['la_crimes_rate', 'parking_citations']




```python
la_parking_df_project.to_sql(name='la_parking_df_project', con=engine, if_exists='replace', index=False)
```


```python
results = engine.execute('select * from la_parking_df_project;')
```

### Confirm data has been added by querying the la_parking_df table


```python
connection.execute('use ladata_db;')
```




    <sqlalchemy.engine.result.ResultProxy at 0x2427fda8a90>




```python
pd.read_sql_query('select * from la_parking_df_project', con=engine).head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Ticket number</th>
      <th>Issue Date</th>
      <th>Issue time</th>
      <th>Meter Id</th>
      <th>Marked Time</th>
      <th>RP State Plate</th>
      <th>Plate Expiry Date</th>
      <th>VIN</th>
      <th>Make</th>
      <th>Body Style</th>
      <th>...</th>
      <th>Agency</th>
      <th>Violation code</th>
      <th>Violation Description</th>
      <th>Fine amount</th>
      <th>Latitude</th>
      <th>Longitude</th>
      <th>Year</th>
      <th>Month</th>
      <th>Day</th>
      <th>Parking_Date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1121041762</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>955.0</td>
      <td>None</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201807.0</td>
      <td>None</td>
      <td>KIA</td>
      <td>PA</td>
      <td>...</td>
      <td>1</td>
      <td>8056E4</td>
      <td>RED ZONE</td>
      <td>93.0</td>
      <td>6.483814e+06</td>
      <td>1.824574e+06</td>
      <td>2018</td>
      <td>01</td>
      <td>01</td>
      <td>2018/01/01</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4324502346</td>
      <td>2018/01/01 12:00:00 AM</td>
      <td>1134.0</td>
      <td>None</td>
      <td>NaN</td>
      <td>CA</td>
      <td>201706.0</td>
      <td>None</td>
      <td>GMC</td>
      <td>TK</td>
      <td>...</td>
      <td>55</td>
      <td>5204A-</td>
      <td>DISPLAY OF TABS</td>
      <td>25.0</td>
      <td>9.999900e+04</td>
      <td>9.999900e+04</td>
      <td>2018</td>
      <td>01</td>
      <td>01</td>
      <td>2018/01/01</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 23 columns</p>
</div>


