# IMPORTANT!
# - In order to use the functions and call them in the terminal make sure you read 
#   the Readme.md first
# - All functions are commented to facilitate their modification if required

def repeat($N):
# @input
#   JSON OBJECT
# @description
#   Repeat an JSON OBJECT an amount of times indicated by $N and returns a LIST (plain)
#   with the number of total objects.
# @output
#   JSON OBJECT/s
# @notes
#   Recursive type function.
# ----------------------------------------------------------------------------------------
    if $N > 0 then
        if type == "object" then
            . as $obj
            |
            [.] # convert to list
            |
            . += [ $obj ] # add item
            |
            repeat($N - 1) # repeat function ..
        else # == "array"
            .[0] as $obj # get first item
            |
            . += [ $obj ] # add item
            |
            repeat($N - 1) # repeat function ..
        end
    else
        if type == "object" then
            .
        else # == "array"
            .[]
        end
    end