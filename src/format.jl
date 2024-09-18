function format_diff(diff_output::Vector{Tuple{Symbol,String,String,String}})
    formatted = IOBuffer()
    for (op, equal_content, insert_content, delete_content) in diff_output
        write(formatted, equal_content)
        if !isempty(delete_content)
            write(formatted, "[-", delete_content, "-]")
        end
        if !isempty(insert_content)
            write(formatted, "{+", insert_content, "+}")
        end
    end
    String(take!(formatted))
end
