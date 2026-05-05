select *
from {{ source('google_sheets', 'google_sheets_budget')}}
where QUANTITY < 0