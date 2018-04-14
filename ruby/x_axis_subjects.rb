# Description
# Given two guys and their position in the X axis, they will move in discrete (integer)
# steps over it in the positive direction, at a rate of Steps per second. 
# Given the pace and the initial position, determine after how many seconds they will meet. 
# If they will never meet, return -1.
#
# Assumptions:
# I created two functions, one for a discrete response, asuming we cannot return split seconds (continuos domain)
# for the first, and using a discrte domain in the second. The discrete response will return -1 if the two
# subject doesn't meet in a integer value of seconds.
#


# we can return fractions of seconds
def continuous(subject_a, subject_b, speed_a, speed_b)
  seconds_required = (subject_a - subject_b) / Float(speed_b - speed_a) # Cast o avoid the exception in case of Zero Division, Ruby issue
  
  if seconds_required.infinite? or seconds_required < 0 # no difference in speed or speed diff is not enough
    return -1
  end
  
  if seconds_required.nan? # Ruby returns NaN When 0/0 we're already there
    return 0.0
  end  
  return seconds_required
end


# we cannot return fraction of seconds

def discrete(subject_a, subject_b, speed_a, speed_b)
  seconds_continuous = continuous(subject_a, subject_b, speed_a, speed_b)
  if seconds_continuous == 0
    return seconds_continuous
  end
  if seconds_continuous % 1 > 0
    # we do not meet in discrete seconds
    return -1
  end
  return seconds_continuous
end



# This are completely ruby issues

test_cases = [
  [1, 1, 2, 2], # Same initial point, same speed => 0
  [1, 1, 2, 5], # Same initial point, different speed => 0
  [1, 2, 2, 2], # Same speed, different initial point => -1 (never meets)  
  [1, 2, 3, 2], # Different initial point, most behind is faster => Meets in continuos and discrete (1)
  [1, 2, 5, 2], # Different initial point, most behind is faster => Meets in continuos and not in discrete
  [1, 100000, 5, 2] # Different initial point, most behind is faster => Meets in continuos and not in discrete
  # any other?
  ]

test_cases.each { |test_case| 
  printf("Continuos %s, Discrete: %s\n", continuous(*test_case), discrete(*test_case))
}
