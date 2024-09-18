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
    compacted = Tuple{Symbol,String,String,String}[]
    current_equal = ""
    current_insert = ""
    current_delete = ""
    current_char_equal = ""
    current_char_insert = ""
    current_char_delete = ""

    for (op, content) in grouped_diff
        if op == :equal
            if !isempty(current_equal) || !isempty(current_insert) || !isempty(current_delete)
                push!(compacted, (:equal, current_equal, current_insert, current_delete))
                current_equal = ""
                current_insert = ""
                current_delete = ""
            end
            if !isempty(current_char_equal) || !isempty(current_char_insert) || !isempty(current_char_delete)
                push!(compacted, (:char_equal, current_char_equal, current_char_insert, current_char_delete))
                current_char_equal = ""
                current_char_insert = ""
                current_char_delete = ""
            end
            current_equal = content
        elseif op == :insert
            current_insert *= content
        elseif op == :delete
            current_delete *= content
        elseif op == :char_equal
            if !isempty(current_equal) || !isempty(current_insert) || !isempty(current_delete)
                push!(compacted, (:equal, current_equal, current_insert, current_delete))
                current_equal = ""
                current_insert = ""
                current_delete = ""
            end
            if !isempty(current_char_equal) || !isempty(current_char_insert) || !isempty(current_char_delete)
                push!(compacted, (:char_equal, current_char_equal, current_char_insert, current_char_delete))
                current_char_equal = ""
                current_char_insert = ""
                current_char_delete = ""
            end
            current_char_equal = content
        elseif op == :char_insert
            current_char_insert *= content
        elseif op == :char_delete
            current_char_delete *= content
        else
            @assert false "Unknown operation: $op"
        end
    end
    
    if !isempty(current_equal) || !isempty(current_insert) || !isempty(current_delete)
        push!(compacted, (:equal, current_equal, current_insert, current_delete))
    end
    if !isempty(current_char_equal) || !isempty(current_char_insert) || !isempty(current_char_delete)
        push!(compacted, (:char_equal, current_char_equal, current_char_insert, current_char_delete))
    end
    
    return compacted
end
