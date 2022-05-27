# example 1: query using native jq >:v
# ----------------------------------------------------------------------------------------
# [
#     .Dates[] | { Date: ("\(.Day)" + "/" + "\(.Month)" + "/" + "\(.Year)") }
# ]

# example 1A: query using utils-jq module :D
# ----------------------------------------------------------------------------------------
[
    .Dates[] | { Date: date_format(.Day; .Month; .Year; "dd/mm/yyyy") }
]