
# AI State struct
@kwdef mutable struct AIStat
	conversations::Dict{String,
	selected_conv_id::String="
	streaming::Bool=true
	skip_code_execution::Bool=f
	model::String = ""
	contexter::AbstractContextC
end

# Initialize AI State
initialize_ai_state(MODEL="cl_tokens, contexter)
	if resume

	print_project_tree(state, s
	println("All things setup!"
	return state
end

function get_all_conversation
	for file in get_all_convers
			conv_info = parse_conve
			state.conversations[con
					timestamp=conv_info
					sentence=conv_info.
					id=conv_info.id
			)
	end
end

function select_conversation(
	state.selected_conv_id = co
	state.conversations[convers
	println("Conversation id se
end

function generate_new_convers
	new_id = generate_conversat
	state.selected_conv_id = ne
	state.conversations[new_id]
end

function update_project_path_
	!isempty(project_paths) && 
	state.conversations[state.s
	println("\e[33mSystem promp
end

add_n_save_user_message!(stat
function add_n_save_user_mess
	push!(curr_conv_msgs(state)
	save_user_message(state, us
	user_msg
end

add_n_save_ai_message!(state:
add_n_save_ai_message!(state:
function add_n_save_ai_messag
	push!(curr_conv_msgs(state)
	save_ai_message(state, ai_m
	ai_msg
end
