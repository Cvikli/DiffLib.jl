## DiffLib.jl

LLM centric diffs. We support wildcards! 

Also CHARACTER and LINE based diff based on the modification amount and percentage. 

NOTE: the package was just created by the LLMs fairly recently.

## DEMO
![image](https://github.com/user-attachments/assets/693e9070-7ca0-4232-9ee9-03e9795f0b62)

## Features
- LLM output parsing
- Word-based and character-based diff
- Wildcard support for flexible matching
- CLI for easy file comparison from terminal
- Customizable output formatting by setting threashold of char or line based diff usage

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/Cvikli/DiffLib.jl")
```

## Usage

```julia
using DiffLib

# Compare two files
diff_files("original.txt", "changed.txt", ["// ... existing code ..."])

# Compare content strings
diff_contents(original_content, changed_content, ["WILDCARD"])
```

```sh
julia -e 'using DiffLib; DiffLib.run_cli()' -- original.txt changed.txt -w "// ... existing code ..."
```

## REASON
LLMs can generate abbreviations, also these can be forced to be generated to faster output:
`// ... existing code ...`
`// ... rest of the existing code ...`
`// ... (previous code remains unchanged)`
`// ... (rest of the code remains unchanged)`
- The git diff often fail to find the diff... also many other diff fails. 
- Also why don't we have more granular diff like word or even character based diff... why should we look for a whole line to find the changes? right? We are humans with limited cognitive speed. :D

## License

This project is licensed under the MIT License.


## TODO
- [x] File path handling
- [x] File readall string handling
- [x] ARGS handling
- [x] Refactor to use indexes
- [x] Typesafety check
- [x] Word based diff
- [x] Even character based diff
- [x] find best match should be keeping the order to verify the match. Also should be - whitespace sensitive probably. Also LCS could be used here too to check matching - line by line.
- [x] Create README.md
- [x] multi wildcard handling in typesafe manner ;)
- [ ] output generation to be modular (maybe buffer like mechanics)
- [ ] JS frontend for a merge tool
- [ ] Integrative new diff handling... Sort of handling the streamed chunked input in - the changes...
- [ ] Testing if it handles consecutive diffs properly
- [ ] Speed measureing... If it isn't infinitly fast...

## HOW did this created?
By AI... used the tool [AISH.jl](https://github.com/Cvikli/AISH.jl)
