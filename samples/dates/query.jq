# get list of dates in other format
# ----------------------------------------------------------------------------------------
include "utils-jq";
[
    .Dates[] | date_format(.Day; .Month; .Year; "dd/mm/yyyy")
]
# how run this query? (in you terminal execute the next command)
# jq -f 'samples/dates/query.jq' samples/dates/dates.json