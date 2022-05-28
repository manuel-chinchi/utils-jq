# get names of persons (on capitalize format)
# ----------------------------------------------------------------------------------------
[
    .names[] | { name: text_format(.name + " " + .lastname; "capit") }
]