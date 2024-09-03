is_wildcards(item, wildcards::Vector{String}) = item in wildcards
is_wildcards(item, wildcards::String)         = item == wildcards

function word_diff_with_wildcard(a_lines::Vector{String}, b_lines::Vector{String}, wildcards::Union{String, Vector{String}}, print_output::Bool=true)
    is_wildcard(item::String)::Bool = is_wildcards(strip(item), wildcards)
    
    output = Tuple{Symbol, String}[]
    i, j = 1, 1
    a_len, b_len = length(a_lines), length(b_lines)

    while j <= b_len
        if is_wildcard(b_lines[j])
            next_content = findnext(line -> !is_wildcard(line) && !isempty(strip(line)), b_lines, j + 1)
            if isnothing(next_content)
                lines = join(a_lines[i:end], "\n")
                print_output && print_equal(lines)
                push!(output, (:equal, lines))
                break
            end
            
            next_wildcard = findnext(is_wildcard, b_lines, next_content + 1)
            isnothing(next_wildcard) && (next_wildcard = b_len)

            next_match = i
            for y in next_content:min(next_content+15,b_len)
                next_match, best_score = find_best_match(b_lines[y], a_lines, i, min(i + (next_wildcard - next_content) + 100, a_len))
                best_score > 0.6 && break
            end
            
            lines = join(a_lines[i:next_match-1], "\n")
            print_output && print_equal(lines)
            push!(output, (:equal, lines))
            
            i = next_match
            j += 1
            continue
        else
            next_wildcard = findnext(is_wildcard, b_lines, j + 1)
            isnothing(next_wildcard) && (next_wildcard = b_len)
        end
        
        diff_output = diff_section(a_lines, b_lines, i, min(i + (next_wildcard - j) - 1, a_len), j, next_wildcard - 1, print_output)
        append!(output, diff_output)
        i += next_wildcard - j
        j = next_wildcard
    end
    
    return output
end
