sstrip(a) = String(strip(a))
score(bs1, s1) = 2*length(char_lcs(bs1, s1)) / (length(bs1) + length(s1))
identify_similar_block(b_lines, j1,jend, a_lines, i, a_len, ) = begin
    done = false
    bx = j1
    ax = i
    jx = bx
    ix = ax
    match_counter = 0
    maxax = 0
    for bx in j1:jend
        score1,score2,score3 = 0f0,0f0,0f0
        bs1 = sstrip(b_lines[bx])
        # @show bs1
        bs2 = sstrip(b_lines[min(bx+1,end)])
        bs3 = sstrip(b_lines[min(bx+2,end)])
        for ax in i:a_len-2
            s1=sstrip(a_lines[ax])
            score1 = score(bs1, s1)
            score1 < 0.9f0 && continue
            match_counter=1
            if match_counter>maxax
                maxax=match_counter
                jx = bx
                ix = ax
            end
            bx+1>jend && continue
            s2=sstrip(a_lines[ax+1])
            score2 = score(bs2, s2)
            score2 < 0.9f0 && continue
            match_counter=2
            if match_counter>maxax
                maxax=match_counter
                jx = bx
                ix = ax
            end
            # @show s1
            # @show s2
            bx+2>jend && continue
            s3=sstrip(a_lines[ax+2])
            score3 = score(bs3, s3)
            score3 < 0.9f0 && continue
            match_counter=3
            if match_counter>maxax
                maxax=match_counter
                jx = bx
                ix = ax
            end
            done = true
            break
        end
        done && (break)
    end
    # @show jend, i, 0
    # isempty(strip(join(b_lines[jx:jx+match_counter-1],""))) && return 
    match_counter > 0 && jend, ix, match_counter
    match_counter==0  && return jend+1, ix, match_counter
    # @show jx,ix,match_counter
    jx,ix,match_counter
end

function find_best_match(needle::String, haystack::Vector{String}, start_idx::Int, end_idx::Int)
    isempty(needle) && return start_idx, 0.0
    
    end_idx = min(end_idx, length(haystack))
    # scoree = [(needle, char_lcs(needle, s), 2*length(char_lcs(needle, s)) / (length(needle) + length(s)), s)  for s in haystack[start_idx:end_idx]]
    # display(scoree)
    scores = [2*length(char_lcs(needle, s)) / (length(needle) + length(s)) for s in haystack[start_idx:end_idx]]
    # display(scores)
    best_idx = argmax(scores)
    # @show start_idx
    # @show best_idx, scores[best_idx]
    
    return best_idx, scores[best_idx]
end

