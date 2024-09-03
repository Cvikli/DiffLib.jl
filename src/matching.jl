
function find_best_match(needle::String, haystack::Vector{String}, start_idx::Int, end_idx)
    needle_words = split(needle)
    isempty(needle_words) && return start_idx, 0.0
    
    best_match, best_idx = 0.0, start_idx
    end_idx=min(end_idx, length(haystack))
    
    for idx in start_idx:end_idx
        match_count = count(w -> w in split(haystack[idx]), needle_words)
        if match_count > best_match
            best_match, best_idx = match_count/length(needle_words), idx
        end
        isapprox(best_match, 1.0) && break  # Perfect match found
    end
    return best_idx, best_match
end

