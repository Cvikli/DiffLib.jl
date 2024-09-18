

handle_interrupt(sig::Int32) = (println("\nExiting gracefully."); exit(0))

ccall(:signal, Ptr{Cvoid}, (Cint, Ptr{Cvoid}), 2, @cfunction(handle_interrupt, Cvoid, (Int32,)))

run_server() = include("server.jl")
@show "test"

run_server()
@show "working?"
