# get names of persons (on capitalize format)
# ----------------------------------------------------------------------------------------
[
    .persons[] | { name: text_format(.name + " " + .lastname; "capit") }
]