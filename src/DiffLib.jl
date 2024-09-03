module DiffLib

using ArgParse

include("printing.jl")
include("matching.jl")
include("lcs.jl")
include("char_diff.jl")
include("word_diff.jl")
include("cli.jl")

export word_diff_with_wildcard, diff_files, diff_contents, run_cli

function diff_contents(original_content::String, changed_content::String, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    original_lines = String.(split(original_content, "\n"))
    changed_lines  = String.(split(changed_content, "\n"))
    
    word_diff_with_wildcard(original_lines, changed_lines, wildcards, print_matched)
end

function diff_files(original_path::String, changed_path::String, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    diff_contents(read(original_path, String), read(changed_path, String), wildcards, print_matched)
end

end # module DiffLib
