
function find_best_match(needle::String, haystack::Vector{String}, start_idx::Int, end_idx::Int)
    isempty(needle) && return start_idx, 0.0
    
    end_idx = min(end_idx, length(haystack))
    scores = [length(char_lcs(needle, s)) / max(length(needle), length(s)) for s in haystack[start_idx:end_idx]]
    best_idx = argmax(scores)
    
    return start_idx + best_idx - 1, scores[best_idx]
end

