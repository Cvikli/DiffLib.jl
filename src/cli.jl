using ArgParse

function parse_arguments()
    s = ArgParseSettings()
    @add_arg_table s begin
        "original"
            help = "Path to the original file"
            required = true
        "changed"
            help = "Path to the changed file"
            required = true
        "--wildcards", "-w"
            help = "Wildcard strings (can be specified multiple times)"
            nargs = '*'
            default = String[]
        "--detailed", "-d"
            help = "Enable detailed print output instead of formatted output"
            action = :store_true
    end

    return parse_args(s)
end

function run_cli()
    args = parse_arguments()
    wildcards = isempty(args["wildcards"]) ? String[] : args["wildcards"]
    result, _ = diff_files(args["original"], args["changed"], wildcards, print_output=args["detailed"])
    if !args["detailed"]
        formatted_output = format_diff(result)
        println(formatted_output)
    end
end
