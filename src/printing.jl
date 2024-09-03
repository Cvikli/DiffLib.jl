const WHITE_ON_RED = "\e[97;41m"
const BLACK_ON_GREEN = "\e[30;42m"
const RESET = "\e[0m"

print_del(s::AbstractString)    = println("$(WHITE_ON_RED)$s$RESET")
print_insert(s::AbstractString) = println("$(BLACK_ON_GREEN)$s$RESET")
print_equal(s::AbstractString)  = println("$s")
