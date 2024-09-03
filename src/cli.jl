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
            nargs = '+'
            default = ["// ... existing code ...", "// ... rest of the existing code ..."]
    end

    return parse_args(s)
end

function run_cli()
    args = parse_arguments()
    diff_files(args["original"], args["changed"], args["wildcards"])
end
