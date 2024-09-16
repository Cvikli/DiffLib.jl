function group_consecutive_lines(diff_result)
	isempty(diff_result) && return diff_result
	
	grouped = Tuple{Symbol,String}[]
	current_op, current_content = diff_result[1]
	
	for item in diff_result[2:end]
        op, content = item
        if op in (:equal, :delete, :insert)
            if op == current_op 
                current_content *= content
            else
                push!(grouped, (current_op, current_content))
                current_op, current_content = op, content
            end
        else
            push!(grouped, (current_op, current_content))
            current_op, current_content = op, content
        end
	end
	push!(grouped, (current_op, current_content))
	
	return grouped
end

function group_consecutive(diff_result)
	isempty(diff_result) && return diff_result
	
	grouped = []
	current_op, current_content = diff_result[1]
	
	for (op, content) in diff_result[2:end]
        if op == current_op
            current_content *= content
        else
            push!(grouped, (current_op, current_content))
            current_op, current_content = op, content
        end
	end
	push!(grouped, (current_op, current_content))
	
	return grouped
end

function compact_diff_result(grouped_diff)
    compacted = Tuple{Symbol,String,String}[]
    current_inserts = String[]
    current_deletes = String[]
    current_char_inserts = String[]
    current_char_deletes = String[]
    
    for (op, content) in grouped_diff
        if op in (:equal, :char_equal)
            if !isempty(current_inserts) || !isempty(current_deletes)
                push!(compacted, (:insert_delete, join(current_inserts), join(current_deletes)))
                current_inserts = String[]
                current_deletes = String[]
            end
            if !isempty(current_char_inserts) || !isempty(current_char_deletes)
                push!(compacted, (:char_insert_delete, join(current_char_inserts), join(current_char_deletes)))
                current_char_inserts = String[]
                current_char_deletes = String[]
            end
            push!(compacted, (op, content, ""))
        elseif op == :insert
            push!(current_inserts, content)
        elseif op == :delete
            push!(current_deletes, content)
        elseif op == :char_insert
            push!(current_char_inserts, content)
        elseif op == :char_delete
            push!(current_char_deletes, content)
        else
            @assert false "unknown cases: $op $content"
        end
    end
    
    if !isempty(current_inserts) || !isempty(current_deletes)
        push!(compacted, (:insert_delete, join(current_inserts), join(current_deletes)))
    end
    if !isempty(current_char_inserts) || !isempty(current_char_deletes)
        push!(compacted, (:char_insert_delete, join(current_char_inserts), join(current_char_deletes)))
    end
    
    return compacted
end
