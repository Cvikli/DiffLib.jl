module DiffLib

using ArgParse

include("printing.jl")
include("matching.jl")
include("lcs.jl")
include("word_diff.jl")
include("cli.jl")

export word_diff_with_wildcard, diff_files, diff_contents, run_cli

function diff_contents(original_content::String, changed_content::String, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    original_lines = String.(split(original_content, "\n"))
    changed_lines  = String.(split(changed_content, "\n"))
    
    word_diff_with_wildcard(original_lines, changed_lines, wildcards, print_matched)
end

function diff_files(original_path::String, changed_path::String, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    original_content = read(original_path, String)
    changed_content = read(changed_path, String)
    
    diff_contents(original_content, changed_content, wildcards, print_matched)
end


end # module DiffLib
