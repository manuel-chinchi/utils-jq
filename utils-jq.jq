# IMPORTANT!
# - In order to use the functions and call them in the terminal make sure you read 
#   the Readme.md first
# - All functions are commented to facilitate their modification if required

def repeat_obj($n):
# @input
#   OBJECT
# @description
#   Repeat an OBJECT an amount of times indicated by $n and returns a LIST (plain)
#   with the number of total objects.
# @output
#   OBJECT/s
# @note
#   Recursive function.
# ----------------------------------------------------------------------------------------
    if $n > 0 then
        if type == "object" then
            . as $obj
            |
            [.] # convert to list
            |
            . += [ $obj ] # add item
        else # == "array"
            .[0] as $obj # get first item
            |
            . += [ $obj ] # add item
        end
        |
        repeat_obj($n - 1) # repeat function..
    else
        if type == "object" then
            .
        else # == "array"
            .[]
        end
    end
    ;

# ========================================================================================
# Date functions
# @note
#   Most of these functions use JQ native functions.
# ========================================================================================

def is_leap_year($year):
# @input
#   INTEGER
# @description
#   Verify if a given year is leap.
# @output
#   INTEGER
# ----------------------------------------------------------------------------------------
    if ( ($year % 4 == 0 and $year % 100 != 0 ) or ($year % 400 == 0) ) then
        true
    else
        false
    end
    ;

def check_date($day; $month; $year):
# @input
#   INTEGER, INTEGER, INTEGER
# @description
#   Check if a given date is valid.
# @output
#   BOOLEAN
# ----------------------------------------------------------------------------------------
    [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] as $days_of_month
    |
    [ range(1; 13) ] as $months_of_year
    |
    (
        $days_of_month | .[1] = ( if is_leap_year($year) == true then 29 else 28 end )
    ) as $days_of_month
    |
    if ( $year > 0 ) then # check year
        if ( $month | IN( $months_of_year | .[] ) ) == true then # check month
            if ( $day > 0 and $day <= $days_of_month[$month - 1] ) then # check day
                true
            else
                false
            end
        else
            false
        end
    else
        false
    end
    ;

# ========================================================================================
# String functions
# @note
#   Most of these functions use JQ native functions.
# ========================================================================================

def sreplace_all($old_sub; $new_sub):
# @description
#   Replaces all the appearances of a subcadene on another inside an initial chain.
# ----------------------------------------------------------------------------------------
    gsub($old_sub; $new_sub)
    ;

def sremove_all($sub):
# @description
#   Remove all the appearances of a subcadence within another initial chain.
# ----------------------------------------------------------------------------------------
    gsub($sub; "")
    ;

def instr($sub):
# @description
#   Returns the position of the first appearance of a subcadence within another.
# ----------------------------------------------------------------------------------------
    index($sub)
    ;