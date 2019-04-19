

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

import random
# The data to load
f = "Resources/LA_crime.csv"

# Count the lines
num_lines = sum(1 for l in open(f))

# Sample size - in this case ~10%
size = int(num_lines / 10)

# The row indices to skip - make sure 0 is not included to keep the header!
skip_idx = random.sample(range(1, num_lines), num_lines - size)

# Read the data
la_crime_df = pd.read_csv(f, skiprows=skip_idx)
la_crime_df.head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Weapon Description</th>
      <th>Status Code</th>
      <th>Status Description</th>
      <th>Crime Code 1</th>
      <th>Crime Code 2</th>
      <th>Crime Code 3</th>
      <th>Crime Code 4</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>NaN</td>
      <td>IC</td>
      <td>Invest Cont</td>
      <td>420</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>(34.1758, -118.379)</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>AA</td>
      <td>Adult Arrest</td>
      <td>510</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>400 S  CROCKER                      ST</td>
      <td>NaN</td>
      <td>(34.0431, -118.3482)</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 26 columns</p>
</div>




```python
# Remove parantesis from Location column
la_crime_df['Location_clean']=la_crime_df['Location '].str.strip('()')
la_crime_df.head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Status Code</th>
      <th>Status Description</th>
      <th>Crime Code 1</th>
      <th>Crime Code 2</th>
      <th>Crime Code 3</th>
      <th>Crime Code 4</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location</th>
      <th>Location_clean</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>IC</td>
      <td>Invest Cont</td>
      <td>420</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>(34.1758, -118.379)</td>
      <td>34.1758, -118.379</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>NaN</td>
      <td>...</td>
      <td>AA</td>
      <td>Adult Arrest</td>
      <td>510</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>400 S  CROCKER                      ST</td>
      <td>NaN</td>
      <td>(34.0431, -118.3482)</td>
      <td>34.0431, -118.3482</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 27 columns</p>
</div>




```python
## https://chrisalbon.com/python/data_wrangling/pandas_split_lat_and_long_into_variables/
# Create two lists for the loop results to be placed
lat = []
lon = []

# For each row in a varible,
for row in la_crime_df['Location_clean']:
    # Try to,
    try:
        # Split the row by comma and append
        # everything before the comma to lat
        lat.append(row.split(',')[0])
        # Split the row by comma and append
        # everything after the comma to lon
        lon.append(row.split(',')[1])
    # But if you get an error
    except:
        # append a missing value to lat
        lat.append(np.NaN)
        # append a missing value to lon
        lon.append(np.NaN)

# Create two new columns from lat and lon
la_crime_df['Latitude'] = lat
la_crime_df['Longitude'] = lon
```


```python
la_crime_df.head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Crime Code 1</th>
      <th>Crime Code 2</th>
      <th>Crime Code 3</th>
      <th>Crime Code 4</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location</th>
      <th>Location_clean</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>420</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>(34.1758, -118.379)</td>
      <td>34.1758, -118.379</td>
      <td>34.1758</td>
      <td>-118.379</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>NaN</td>
      <td>...</td>
      <td>510</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>400 S  CROCKER                      ST</td>
      <td>NaN</td>
      <td>(34.0431, -118.3482)</td>
      <td>34.0431, -118.3482</td>
      <td>34.0431</td>
      <td>-118.3482</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 29 columns</p>
</div>




```python
print(f"LA Crime number of rows = {la_crime_df['DR Number'].count()}")
```

    LA Crime number of rows = 7918
    


```python
# Strip parentheses from column
la_crime_df['Location_clean']=la_crime_df['Location '].str.strip('()')
la_crime_df.head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Crime Code 1</th>
      <th>Crime Code 2</th>
      <th>Crime Code 3</th>
      <th>Crime Code 4</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location</th>
      <th>Location_clean</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>420</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>(34.1758, -118.379)</td>
      <td>34.1758, -118.379</td>
      <td>34.1758</td>
      <td>-118.379</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>NaN</td>
      <td>...</td>
      <td>510</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>400 S  CROCKER                      ST</td>
      <td>NaN</td>
      <td>(34.0431, -118.3482)</td>
      <td>34.0431, -118.3482</td>
      <td>34.0431</td>
      <td>-118.3482</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 29 columns</p>
</div>




```python
# Separate Date column by day, month and year and the complete date without the hours
```


```python
la_crime_df['Year'] = [i[8:10] for i in la_crime_df['Date Reported']]
```


```python
la_crime_df['Month'] = [i[3:5] for i in la_crime_df['Date Reported']]
```


```python
la_crime_df['Day'] = [i[0:2] for i in la_crime_df['Date Reported']]
```


```python
la_crime_df['Parking_Date'] = [i[0:10] for i in la_crime_df['Date Reported']]
```


```python
la_crime_df.head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location</th>
      <th>Location_clean</th>
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
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>(34.1758, -118.379)</td>
      <td>34.1758, -118.379</td>
      <td>34.1758</td>
      <td>-118.379</td>
      <td>19</td>
      <td>03</td>
      <td>01</td>
      <td>01/03/2019</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>NaN</td>
      <td>...</td>
      <td>400 S  CROCKER                      ST</td>
      <td>NaN</td>
      <td>(34.0431, -118.3482)</td>
      <td>34.0431, -118.3482</td>
      <td>34.0431</td>
      <td>-118.3482</td>
      <td>19</td>
      <td>02</td>
      <td>01</td>
      <td>01/02/2019</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 33 columns</p>
</div>




```python
la_crime_df.columns
```




    Index(['DR Number', 'Date Reported', 'Date Occurred', 'Time Occurred',
           'Area ID', 'Area Name', 'Reporting District', 'Crime Code',
           'Crime Code Description', 'MO Codes', 'Victim Age', 'Victim Sex',
           'Victim Descent', 'Premise Code', 'Premise Description',
           'Weapon Used Code', 'Weapon Description', 'Status Code',
           'Status Description', 'Crime Code 1', 'Crime Code 2', 'Crime Code 3',
           'Crime Code 4', 'Address', 'Cross Street', 'Location ',
           'Location_clean', 'Latitude', 'Longitude', 'Year', 'Month', 'Day',
           'Parking_Date'],
          dtype='object')




```python
# select columns to use for the project
la_crime_df_new = la_crime_df[['DR Number', 'Date Reported', 'Date Occurred', 'Time Occurred',
       'Area ID', 'Area Name', 'Reporting District', 'Crime Code',
       'Crime Code Description', 'MO Codes', 'Victim Age', 'Victim Sex',
       'Victim Descent', 'Premise Code', 'Premise Description',
       'Weapon Used Code', 'Weapon Description', 'Status Code',
       'Status Description', 'Crime Code 1', 'Crime Code 2', 'Crime Code 3',
       'Crime Code 4', 'Address', 'Cross Street','Location_clean', 'Latitude', 'Longitude', 'Year', 'Month', 'Day',
       'Parking_Date']]
```


```python
la_crime_df_new.head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Crime Code 4</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location_clean</th>
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
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>NaN</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>34.1758, -118.379</td>
      <td>34.1758</td>
      <td>-118.379</td>
      <td>19</td>
      <td>03</td>
      <td>01</td>
      <td>01/03/2019</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>400 S  CROCKER                      ST</td>
      <td>NaN</td>
      <td>34.0431, -118.3482</td>
      <td>34.0431</td>
      <td>-118.3482</td>
      <td>19</td>
      <td>02</td>
      <td>01</td>
      <td>01/02/2019</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 32 columns</p>
</div>




```python
# save df to a csv file
la_crime_df_new.to_csv(r'Resources\la_crime_df_new.csv')
```

### Connect to local database


```python
# Connect to local database
rds_connection_string = "root:modelobootcamp@127.0.0.1/ladata_db"
engine = create_engine(f'mysql://{rds_connection_string}')
connection = engine.connect()
```


```python
connection.execute('use ladata_db;')
```




    <sqlalchemy.engine.result.ResultProxy at 0x264fd217e80>




```python
engine.table_names()
```




    ['la_parking_df_project']




```python
la_crime_df_new.to_sql(name='la_crime_df_project', con=engine, if_exists='replace', index=False)
```


```python
results = engine.execute('select * from la_crime_df_project;')
```

### Confirm data has been added by querying the la_parking_df table


```python
connection.execute('use ladata_db;')
```




    <sqlalchemy.engine.result.ResultProxy at 0x264fee34d68>




```python
pd.read_sql_query('select * from la_crime_df_project', con=engine).head(2)
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
      <th>DR Number</th>
      <th>Date Reported</th>
      <th>Date Occurred</th>
      <th>Time Occurred</th>
      <th>Area ID</th>
      <th>Area Name</th>
      <th>Reporting District</th>
      <th>Crime Code</th>
      <th>Crime Code Description</th>
      <th>MO Codes</th>
      <th>...</th>
      <th>Crime Code 4</th>
      <th>Address</th>
      <th>Cross Street</th>
      <th>Location_clean</th>
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
      <td>191504131</td>
      <td>01/03/2019</td>
      <td>01/02/2018</td>
      <td>2330</td>
      <td>15</td>
      <td>N Hollywood</td>
      <td>1535</td>
      <td>420</td>
      <td>THEFT FROM MOTOR VEHICLE - PETTY ($950 &amp; UNDER)</td>
      <td>0344</td>
      <td>...</td>
      <td>NaN</td>
      <td>TUJUNGA</td>
      <td>HATTERAS</td>
      <td>34.1758, -118.379</td>
      <td>34.1758</td>
      <td>-118.379</td>
      <td>19</td>
      <td>03</td>
      <td>01</td>
      <td>01/03/2019</td>
    </tr>
    <tr>
      <th>1</th>
      <td>190704048</td>
      <td>01/02/2019</td>
      <td>01/02/2018</td>
      <td>1000</td>
      <td>7</td>
      <td>Wilshire</td>
      <td>774</td>
      <td>510</td>
      <td>VEHICLE - STOLEN</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>400 S  CROCKER                      ST</td>
      <td>None</td>
      <td>34.0431, -118.3482</td>
      <td>34.0431</td>
      <td>-118.3482</td>
      <td>19</td>
      <td>02</td>
      <td>01</td>
      <td>01/02/2019</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 32 columns</p>
</div>


