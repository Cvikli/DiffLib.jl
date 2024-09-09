function format_diff(diff_output::Vector{Tuple{Symbol,String}})
    formatted = IOBuffer()
    for (op, content) in diff_output
				if op == :equal || op == :char_equal
						write(formatted, content)
				elseif op == :insert || op == :char_insert
						write(formatted, "{+", content, "+}")
				elseif op == :delete || op == :char_delete
						write(formatted, "[-", content, "-]")
				end
				
				op in [:insert, :equal, :delete] && write(formatted, '\n')
    end
    String(take!(formatted))
end
