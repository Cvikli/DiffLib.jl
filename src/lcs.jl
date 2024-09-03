function lcs(a::Vector{String}, b::Vector{String}, a_start::Int, a_end::Int, b_start::Int, b_end::Int)
    m = a_end - a_start + 1
    n = b_end - b_start + 1
    dp = zeros(Int, m+1, n+1)
    for i in 1:m, j in 1:n
        dp[i+1, j+1] = a[a_start+i-1] == b[b_start+j-1] ? dp[i, j] + 1 : max(dp[i+1, j], dp[i, j+1])
    end
    
    lcs_result = String[]
    i, j = m+1, n+1
    while i > 1 && j > 1
        if a[a_start+i-2] == b[b_start+j-2]
            pushfirst!(lcs_result, a[a_start+i-2])
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

function diff_section(a::Vector{String}, b::Vector{String}, a_start::Int, a_end::Int, b_start::Int, b_end::Int, print_matched::Bool)
    _, lcs_result = lcs(a, b, a_start, a_end, b_start, b_end)
    i, j = a_start, b_start
    
    for common in lcs_result
        while i <= a_end && a[i] != common
            j <= b_end && b[j] != common && print_diff(a[i], b[j])
            i += 1
            j += 1
        end
        while j <= b_end && b[j] != common
            print_insert(b[j])
            j += 1
        end
        print_matched && print_equal(common)
        i += 1
        j += 1
    end


    return i - a_start
end

