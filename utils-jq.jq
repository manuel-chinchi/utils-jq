# IMPORTANT!
# - In order to use the functions and call them in the terminal make sure you read 
#   the Readme.md first
# - All functions are commented to facilitate their modification if required

# ========================================================================================
# Primivite functions
#   Functions made to facilitate the reading of jq's own syntax.
# ========================================================================================

def return($v):
    $v;

def mod($n):
    if  $n < 0 then (-1)*$n else $n end
    ;

# ----------------------------------------------------------------------------------------
# @public Repeat an OBJECT an amount of times indicated by $n and returns a LIST (plain) with the number of total objects. 
# @param {object} Object to copy
# @return {object|Array<object>}
# @note Recursive function
def repeat_obj($n):
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

# ----------------------------------------------------------------------------------------
# @public Verify if a given year is leap.
# @param {number} $year Year
# @return {boolean}
def is_leap_year($year):
    if ( ($year % 4 == 0 and $year % 100 != 0 ) or ($year % 400 == 0) ) then
        true
    else
        false
    end
    ;

# ----------------------------------------------------------------------------------------
# @public Check if a given date is valid.
# @param {number} $day Day
# @param {number} $month Month
# @param {number} $year Year
# @return {boolean}
def check_date($day; $month; $year):
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

#TODO use 'ends' because 'end' is a reserved word.
def days_between_years($year1; $year2):
    (
        if $year1 == $year2 then
            return (0)
        else
            (
                if $year1 < $year2 then
                    return ({ init: $year1, ends: $year2 })
                elif $year1 > $year2 then
                    return ({ init: $year2, ends: $year1 })
                else
                    null
                end
            ) as $years
            |
            [
                range($years.init; $years.ends) as $year
                |
                if is_leap_year($year) then
                    return (366)
                else
                    return (365)
                end
            ]
            |
            return (add) # sum all items of array
        end
    ) | .
    ;

def days_between_dates($day1; $month1; $year1; $day2; $month2; $year2):
    (
        if is_leap_year($year1) == true then
            return ([31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
        else
            return ([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
        end
    ) as $days_of_month1
    |
    mod($year1 - $year2) as $diff_years
    |
    mod($month1 - $month2) as $diff_months
    |
    if $diff_years == 0 then
        if $diff_months == 0 then
            return (mod($day1 - $day2))
        else
            return
            (
                # remaining days of the 'month1'
                (
                    # [ range($day1; $days_of_month1[ ($month1 - 1) ] + 1) ] | length
                    $days_of_month1[ ($month1 - 1) ] - $day1
                ) +
                # days between months 'month1' + 1 and 'month2'
                (
                    $days_of_month1[$month1 + 1: $month2] + [0] | add
                ) +
                #  days from the 1st of the month until 'day2'
                (
                    $day2
                )
            )
        end
    else
        (
            if is_leap_year($year2) == true then
                return ([31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
            else
                return ([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
            end
        ) as $days_of_month2
        |
        return
        (
            # remaining days of the 'month1'
            (
                # [ range($day1 + 1; $days_of_month1[ ($month1 - 1) ]) ] + [0] | length
                $days_of_month1[ ($month1 - 1) ] - $day1
            ) +
            # days of months remaining from 'month1' + 1
            (
                $days_of_month1[$month1:] + [0] | add
            ) +
            # days between years (if the difference in years is greater than 1) 
            (
                days_between_years($year1 + 1; $year2)
            ) +
            # days from month of january to month 'month2'
            (
                $days_of_month2[0: ($month2 - 1)] + [0] | add
            ) +
            # days from the 1st of the month until 'day2'
            (
                # [ range(1; $day2 + 1) ] | length
                $day2
            )
        )
    end
    ;



# ========================================================================================
# String functions
# @note
#   Most of these functions use JQ native functions.
# ========================================================================================

# ----------------------------------------------------------------------------------------
# @public Replaces all the appearances of a subcadene on another inside an initial chain.
# @param {string} $old_sub Old string 
# @param {string} $new_sub New string to replace
def sreplace_all($old_sub; $new_sub):
    gsub($old_sub; $new_sub)
    ;

# ----------------------------------------------------------------------------------------
# @public Remove all the appearances of a subcadence within another initial chain.
# @param {string} $sub Sub string 
def sremove_all($sub):
    gsub($sub; "")
    ;

# ----------------------------------------------------------------------------------------
# @public Returns the position of the first appearance of a subcadence within another.
# @param {string} $sub Sub string  
def instr($sub):
    index($sub)
    ;