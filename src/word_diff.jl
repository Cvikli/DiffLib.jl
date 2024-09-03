is_wildcards(item, wildcards::Vector{String}) = item in wildcards
is_wildcards(item, wildcards::String)         = item == wildcards

function word_diff_with_wildcard(a_lines, b_lines, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    is_wildcard(item) = is_wildcards(strip(item), wildcards)

    i, j = 1, 1

    while j <= length(b_lines)
        if is_wildcard(b_lines[j])
            next_content = findnext(item -> !is_wildcard(strip(item)) && !isempty(strip(item)), b_lines, j+1)
            
            if next_content === nothing
                foreach(print_equal, a_lines[i:end])
                break
            else

                next_wildcard = findnext(is_wildcard, b_lines, next_content+1)
                next_wildcard = next_wildcard === nothing ? length(b_lines) + 1 : next_wildcard

                next_match = i
                for y in 0:15
                    next_content+y > length(b_lines) && break
                    # @show b_lines[next_content+y]
                    next_match, best_score = find_best_match(b_lines[next_content+y], a_lines, i, i+next_wildcard- next_content+100) 
                    # @show next_match, best_score
                    best_score > 0.6 && break
                end
                
                # Print everything from current position to next match as equal
                for line in a_lines[i:next_match-1]
                    print_equal(line)
                end
                
                # Update current position in a_lines
                i = next_match
                
                
                lines_processed = diff_section(a_lines[i:min(i+(next_wildcard-next_content-1), length(a_lines))], b_lines[next_content:next_wildcard-1], print_matched)
                i += lines_processed-1
                j = next_wildcard
            end
        else
            # Handle non-WILDCARD lines
            next_wildcard = findnext(is_wildcard, b_lines, j+1)
            next_wildcard = next_wildcard === nothing ? length(b_lines) + 1 : next_wildcard
            
            lines_processed=diff_section(a_lines[i:min(i+(next_wildcard-j-1), length(a_lines))], b_lines[j:next_wildcard-1], print_matched)
            
            i += lines_processed
            j = next_wildcard
        end
    end
end
