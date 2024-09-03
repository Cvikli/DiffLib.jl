is_wildcards(item, wildcards::Vector{String}) = item in wildcards
is_wildcards(item, wildcards::String)         = item == wildcards

function word_diff_with_wildcard(a_lines::Vector{String}, b_lines::Vector{String}, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    is_wildcard(item::String)::Bool = is_wildcards(strip(item), wildcards)

    i, j = 1, 1
    a_len, b_len = length(a_lines), length(b_lines)

    while j <= b_len
        if is_wildcard(b_lines[j])
            next_content = j + 1
            while next_content <= b_len && (is_wildcard(b_lines[next_content]) || isempty(strip(b_lines[next_content])))
                next_content += 1
            end
            
            if next_content > b_len
                for k in i:a_len
                    print_matched && print_equal(a_lines[k])
                end
                break
            else
                next_wildcard = next_content + 1
                while next_wildcard <= b_len && !is_wildcard(b_lines[next_wildcard])
                    next_wildcard += 1
                end

                next_match = i
                for y in 0:15
                    if next_content + y > b_len
                        break
                    end
                    next_match, best_score = find_best_match(b_lines[next_content + y], a_lines, i, min(i + (next_wildcard - next_content) + 100, a_len))
                    if best_score > 0.6
                        break
                    end
                end
                
                for k in i:next_match-1
                    print_matched && print_equal(a_lines[k])
                end
                
                i = next_match
                
                lines_processed = diff_section(a_lines, b_lines, i, min(i + (next_wildcard - next_content) - 1, a_len), next_content, next_wildcard - 1, print_matched)
                i += lines_processed - 1
                j = next_wildcard
            end
        else
            next_wildcard = j + 1
            while next_wildcard <= b_len && !is_wildcard(b_lines[next_wildcard])
                next_wildcard += 1
            end
            
            lines_processed = diff_section(a_lines, b_lines, i, min(i + (next_wildcard - j) - 1, a_len), j, next_wildcard - 1, print_matched)
            
            i += lines_processed
            j = next_wildcard
        end
    end
end
