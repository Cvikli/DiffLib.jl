
// ... existing code ...

    n = b_end - b_start + 1
    n = b_end - b_start + 1

    dp = zeros(Int, m+1, n+1)
    for i in 1:m+1, j in 1:n
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

// ... rest of the existing code ...
