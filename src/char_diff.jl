function char_lcs(a::String, b::String)
    m, n = length(a), length(b)
    dp = zeros(Int, m+1, n+1)
    for i in 1:m, j in 1:n
        dp[i+1, j+1] = a[i] == b[j] ? dp[i, j] + 1 : max(dp[i+1, j], dp[i, j+1])
    end
    
    lcs_result = Char[]
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
    
    return String(lcs_result)
end

function char_diff(a::String, b::String)
    lcs = char_lcs(a, b)
    i, j, k = 1, 1, 1
    result = ""
    changes = 0
    
    while k <= length(lcs)
        while i <= length(a) && a[i] != lcs[k]
            result *= "$(WHITE_ON_RED)$(a[i])$(RESET)"
            i += 1
            changes += 1
        end
        while j <= length(b) && b[j] != lcs[k]
            result *= "$(BLACK_ON_GREEN)$(b[j])$(RESET)"
            j += 1
            changes += 1
        end
        result *= lcs[k]
        i += 1
        j += 1
        k += 1
    end
    
    while i <= length(a)
        result *= "$(WHITE_ON_RED)$(a[i])$(RESET)"
        i += 1
        changes += 1
    end
    while j <= length(b)
        result *= "$(BLACK_ON_GREEN)$(b[j])$(RESET)"
        j += 1
        changes += 1
    end
    
    return result, changes
end

function is_minor_change(a::String, b::String, max_changes::Int = 5, max_change_ratio::Float64 = 0.5)
    _, changes = char_diff(a, b)
    return changes <= max_changes || changes / max(length(a), length(b)) <= max_change_ratio
end
