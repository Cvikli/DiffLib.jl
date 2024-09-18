meld ./server_unstoppable.jl <(cat <<'EOF'
handle_interrupt(sig::Int32) = (println("\nStopping smoothly."); exit(0))

ccall(:signal, Ptr{Cvoid}, (Cint, Ptr{Cvoid}), 2, @cfunction(handle_interrupt, Cvoid, (Int32,)))

run_server() = include("server.jl")
@show "init"

run_server()
@show "active?"

EOF
)