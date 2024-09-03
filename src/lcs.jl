function lcs(a::Vector{String}, b::Vector{String})
    m, n = length(a), length(b)
    dp = zeros(Int, m+1, n+1)
    for i in 1:m, j in 1:n
        dp[i+1, j+1] = a[i] == b[j] ? dp[i, j] + 1 : max(dp[i+1, j], dp[i, j+1])
    end
    
    lcs_result = String[]
    i, j = m+1, n+1
    while i > 1 && j > 1
        if a[i-1] == b[j-1]
            pushfirst!(lcs_result, a[i-1])
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

function diff_section(a::Vector{String}, b::Vector{String}, print_matched::Bool)
    dp, lcs_result = lcs(a, b)
    i, j, k = 1, 1, 1
    lines_processed = 0
    
    while k <= length(lcs_result)
        while i <= length(a) && a[i] != lcs_result[k]
            print_del(a[i])
            i += 1
            lines_processed += 1
        end
        while j <= length(b) && b[j] != lcs_result[k]
            print_insert(b[j])
            j += 1
        end
        if print_matched
            print_equal(lcs_result[k])
        end
        i += 1
        j += 1
        k += 1
        lines_processed += 1
    end

    return lines_processed
end
