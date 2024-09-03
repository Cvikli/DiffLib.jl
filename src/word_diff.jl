is_wildcards(item, wildcards::Vector{String}) = item in wildcards
is_wildcards(item, wildcards::String)         = item == wildcards

function word_diff_with_wildcard(a_lines::Vector{String}, b_lines::Vector{String}, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    is_wildcard(item::String)::Bool = is_wildcards(strip(item), wildcards)

    i, j = 1, 1
    a_len, b_len = length(a_lines), length(b_lines)

    while j <= b_len
        if is_wildcard(b_lines[j])
            next_content = findnext(line -> !is_wildcard(line) && !isempty(strip(line)), b_lines, j + 1)
            isnothing(next_content) && ((print_matched && foreach(print_equal, a_lines[i:end])); break)
            
            
            next_wildcard = findnext(is_wildcard, b_lines, next_content + 1)
            isnothing(next_wildcard) && (next_wildcard = b_len)

            next_match = i
            for y in next_content:min(next_content+15,b_len)
                next_match, best_score = find_best_match(b_lines[y], a_lines, i, min(i + (next_wildcard - next_content) + 100, a_len))
                best_score > 0.6 && break
            end
            
            print_matched && foreach(print_equal, a_lines[i:next_match-1])
            
            i = next_match
        else
            next_wildcard = findnext(is_wildcard, b_lines, j + 1)
            isnothing(next_wildcard) && (next_wildcard = b_len)
        end
        
        lines_processed = diff_section(a_lines, b_lines, i, min(i + (next_wildcard - j) - 1, a_len), j, next_wildcard - 1, print_matched)
        i += lines_processed - (is_wildcard(b_lines[j]) ? 1 : 0)
        j = next_wildcard
    end
end
