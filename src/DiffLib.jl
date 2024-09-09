module DiffLib

using ArgParse

include("printing.jl")
include("matching.jl")
include("grouping.jl")
include("lcs.jl")
include("lcs_char.jl")
include("diff.jl")
include("cli.jl")
include("format.jl")

export diff_files, diff_contents, run_cli, format_diff

nsplit(ss) = String.(split(ss, "\n"))

function diff_contents(original_content::String, changed_content::String, wildcards::Union{String, Vector{String}}=String[]; print_output::Bool=false)
    if isempty(wildcards)
        diff_without_wildcard(nsplit(original_content), nsplit(changed_content), print_output)
    else
        diff_with_wildcard(nsplit(original_content), nsplit(changed_content), wildcards, print_output)
    end
end

diff_files(original_path::String, changed_path::String, wildcards::Union{String, Vector{String}}=String[]; print_output::Bool=false) = diff_contents(read(original_path, String), read(changed_path, String), wildcards; print_output)

end # module DiffLib
