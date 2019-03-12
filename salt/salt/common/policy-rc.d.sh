#! /bin/sh
# see also: 
# https://people.debian.org/~hmh/invokerc.d-policyrc.d-specification.txt
# invoke-rc.d foobar start ->
# policy-rc.d foobar start

# todo: implement more fine grained policy; 
#   e.g. for some things we are ok with letting this cook.
#
# Exit status codes (LSB compatible):
#   0      : success 
#   1 - 99 : reserved for init.d script
#  100     : init script ID (basename) unknown
#  101     : action not allowed
#  102	 : subsystem error
#  103	 : syntax error
#  104	 : action allowed
#  105	 : behaviour uncertain
#  106     : fallback action requested
#
# exit 101

# see also an example:
# https://github.com/gpapilion/policy-rc.d/blob/master/scripts/policy-rc.d

# for now, just log and let it slide
logger -t `basename $0` $*

exit 0; # default to OK
