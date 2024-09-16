

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


function diff_section(a::Vector{String}, b::Vector{String}, a_start::Int, a_end::Int, b_start::Int, b_end::Int, print_output::Bool)
    _, lcs_result = lcs(a, b, a_start, a_end, b_start, b_end)
    i, j = a_start, b_start
    output = []
    
    for common in lcs_result
        while i <= a_end && a[i] != common
            if j <= b_end && b[j] != common
                if is_minor_change(a[i], b[j])
                    char_diff_result = char_diff(a[i], b[j])
                    if print_output
                        for (op, content) in char_diff_result
                            if op == :char_delete
                                print(WHITE_ON_RED * content * RESET)
                            elseif op == :char_insert
                                print(BLACK_ON_GREEN * content * RESET)
                            else # :char_equal
                                print(content)
                            end
                        end
                        println()
                    end
                    append!(output, char_diff_result)
                else
                    print_output && (print_del(a[i] * "\n"); print_insert(b[j] * "\n"))
                    push!(output, (:delete, a[i] * "\n"))
                    push!(output, (:insert, b[j] * "\n"))
                end
                i += 1
                j += 1
            else
                print_output && print_del(a[i] * "\n")
                push!(output, (:delete, a[i] * "\n"))
                i += 1
            end
        end
        while j <= b_end && b[j] != common
            print_output && print_insert(b[j] * "\n")
            push!(output, (:insert, b[j] * "\n"))
            j += 1
        end
        print_output && print_equal(common * "\n")
        push!(output, (:equal, common * "\n"))
        i += 1
        j += 1
    end

    return group_consecutive_lines(output), i
end

