handle_interrupt(sig::Int32) = (println("\nExiting gracefully."); exit(0))

ccall(:signal, Ptr{Cvoid}, (Cint, Ptr{Cvoid}), 2, @cfunction(handle_interrupt, Cvoid, (Int32,)))

run_server() = include("server.jl")
@show "Server initialization started"

run_server()
@show "Server execution completed"