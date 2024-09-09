
function group_consecutive_lines(diff_result)
	isempty(diff_result) && return diff_result
	
	grouped = Tuple{Symbol,String}[]
	current_op, current_content = diff_result[1]
	
	for item in diff_result[2:end]
			op, content = item
			if op in (:equal, :delete, :insert)
					if op == current_op 
							current_content *= "\n" * content
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