

is_wildcards(item, wildcards::Vector{String}) = item in wildcards
is_wildcards(item, wildcard::String)         = startswith(item, wildcard)

function diff_with_wildcard(a_lines::Vector{String}, b_lines::Vector{String}, wildcards::Union{String, Vector{String}}, print_output::Bool=true)
    is_wildcard(item::String)::Bool = is_wildcards(strip(item), wildcards)
    
    output = Tuple{Symbol,String}[]
    i, j = 1, 1
    a_len, b_len = length(a_lines), length(b_lines)
    
    were_there_weak_match = false

    while j <= b_len
        if is_wildcard(b_lines[j])
            next_wildcard = findnext(is_wildcard, b_lines, j + 1)
            isnothing(next_wildcard) && (next_wildcard = b_len + 1)

            bi, ai, match_strength = identify_similar_block(b_lines, j+1,next_wildcard-1, a_lines, i, a_len,)
            match_strength < 3 && (were_there_weak_match = true)
            
            lines = join(a_lines[i:ai-1], "\n")
            !isempty(lines) && ((print_output && print_equal(lines)); push!(output, (:equal, lines)))
            
            lines = join(b_lines[j+1:bi-1], "\n")
            !isempty(lines) && (print_insert(lines); push!(output, (:insert, lines)))
            
            j = bi
            i = ai
        else
            next_wildcard = findnext(is_wildcard, b_lines, j + 1)
            isnothing(next_wildcard) && (next_wildcard = b_len + 1)
        end
        diff_output, i_new = diff_section(a_lines, b_lines, i, a_len, j, next_wildcard - 1, print_output)
        append!(output, diff_output)
        i = i_new
        j = next_wildcard
    end

    lines = join(a_lines[i:end], "\n")
    !isempty(lines) && ((print_output && print_equal(lines)); push!(output, (:equal, lines)))
    
    output = compact_diff_result(output)
    return output, were_there_weak_match
end

function diff_without_wildcard(a_lines::Vector{String}, b_lines::Vector{String}, print_output::Bool=true)
    output, i_new = diff_section(a_lines, b_lines, 1, length(a_lines), 1, length(b_lines), print_output)
    return compact_diff_result(output), false
end
