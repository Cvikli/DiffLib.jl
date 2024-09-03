module Differ

// ... existing code ...

function lcs(a::Vector{String}, b::Vector{String})
    m, n = length(a), length(b)
    dp = zeros(Int, m+1, n+1)
    for i in 1:m, j in 1:n
        if a[i] == b[j]
            dp[i+1, j+1] = dp[i, j] + 1
        else
            dp[i+1, j+1] = max(dp[i+1, j], dp[i, j+1])
        end
    end
    
    # Reconstruct the LCS
    lcs_result = String[]
    i, j = m, n
    while i > 0 && j > 0
        if a[i] == b[j]
            pushfirst!(lcs_result, a[i])
            i -= 1
            j -= 1
        elseif dp[i, j] == dp[i-1, j]
            i -= 1
        else
            j -= 1
        end
    end
    
    return dp, lcs_result
end

// ... existing code ...

function is_wildcard(item::WILDCARD)
    if item isa String
        return item == "WILDCARD"
    elseif item isa Vector{String}
        return !isempty(item) && all(x -> x == "WILDCARD", item)
    end
    return false
end

function word_diff_with_wildcard(a_lines, b_lines, wildcards::Union{String, Vector{String}}, print_matched::Bool=true)
    i, j = 1, 1

    while j <= length(b_lines)
        if is_wildcard(b_lines[j])
            # Handle WILDCARD (String or Vector{String})
            wildcard_length = b_lines[j] isa Vector ? length(b_lines[j]) : 1
            j += wildcard_length

            # Find next non-wildcard content after WILDCARD
            next_content = findnext(item -> !is_wildcard(item), b_lines, j)
            
            if next_content === nothing
                # If no more content after WILDCARD, print remaining lines from a_lines
                for line in a_lines[i:end]
                    print_equal(line)
                end
                break
            else
                next_wildcard = findnext(is_wildcard, b_lines, next_content+1)
                next_wildcard = next_wildcard === nothing ? length(b_lines) + 1 : next_wildcard

                # Find best match for the next content line in a_lines
                next_match = find_best_match(b_lines[next_content] isa Vector ? join(b_lines[next_content], "\n") : b_lines[next_content], a_lines, i, length(a_lines))
                
                # Print everything from current position to next match as equal
                for line in a_lines[i:next_match-1]
                    print_equal(line)
                end
                
                # Update current position in a_lines
                i = next_match
                
                # Perform LCS on the chunk
                a_chunk = a_lines[i:min(i+(next_wildcard-next_content-1), length(a_lines))]
                b_chunk = b_lines[next_content:next_wildcard-1]
                b_chunk_flat = vcat([x isa Vector ? x : [x] for x in b_chunk]...)
                diff_section(a_chunk, b_chunk_flat, print_matched)
                
                # Update positions
                i += length(a_chunk)
                j = next_wildcard
            end
        else
            # Handle non-WILDCARD lines
            next_wildcard = findnext(is_wildcard, b_lines, j+1)
            next_wildcard = next_wildcard === nothing ? length(b_lines) + 1 : next_wildcard
            
            a_chunk = a_lines[i:min(i+(next_wildcard-j-1), length(a_lines))]
            b_chunk = b_lines[j:next_wildcard-1]
            b_chunk_flat = vcat([x isa Vector ? x : [x] for x in b_chunk]...)
            diff_section(a_chunk, b_chunk_flat, print_matched)
            
            i += length(a_chunk)
            j = next_wildcard
        end
    end
end

// ... rest of the existing code ...

end # module Differ