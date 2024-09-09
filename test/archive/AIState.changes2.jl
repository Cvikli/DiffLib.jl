
function update_project_path_and_sysprompt!(state::AIState, project_paths::Vector{String}=String[])
  set_project_path(state)
  conv = curr_conv(state)
  codebase_ctx = projects_ctx(conv.rel_project_paths)
  conv.system_message = Message(timestamp=now(UTC), role=:system, content=SYSTEM_PROMPT(ctx=codebase_ctx))
  println("\e[33mSystem prompt updated due to file changes.\e[0m")
end


