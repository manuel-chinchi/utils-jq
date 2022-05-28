# get list of names (on capitalize format)
# ----------------------------------------------------------------------------------------
include "utils-jq";
[
    .names[] | text_format(.firstname + " " + .lastname; "capit")
]

# how run this query? (in you terminal execute the next command)
# jq -f 'samples/names/query.jq' samples/names/names.json