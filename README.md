## DiffLib.jl

Parse LLM's codeblock and let's create a git diff on your own codebase. That is why this diff support [WILDCARDS](https://github.com/Cvikli/DiffLib.jl?tab=readme-ov-file#reason) too! 

Also CHARACTER and LINE based diff based on the modification amount and percentage. 


NOTE: LLMs can create even better diffs with their wildcard. So all in all I suggest to create the extended version of the file with an LLM diff and then run this script to get very nice diffs. 

## DEMO
```sh
julia -e "using DiffLib; run_cli()" test_cases/case0.js test_cases/case0_changes.js -d
```
![image](https://github.com/user-attachments/assets/1439067e-4ba2-43a9-a6bd-8d3339170a43)
or get the diff like `git diff --word-diff` does:
```sh
julia -e "using DiffLib; run_cli()" test_cases/case0.js test_cases/case0_changes.js
```
![image](https://github.com/user-attachments/assets/7fdd5602-149d-4ab0-830b-4550050c5a96)



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
`// ... existing imports ...`
`// ... rest of the component ...`
`// ... rest of the component remains the same`
`// ... rest of the existing styles ...`
`// ... rest of the existing code ...`
`// ... (rest of the code remains unchanged)`
`// ... other styled components remain the same`
`// ... (previous code remains unchanged)`
`// ... imports remain the same`
`// ... rest of the component (remove any font-size: 20px declarations) ...`
`// ... (keep other code unchanged)`
`// ... (keep other styled components and imports unchanged)`
`// ... existing JSX ...`
`// ... existing useEffect and functions ...`
`// ... (keep existing state variables)`
`// ... (keep existing values)`
`// ... (keep existing code)`
`// ... (keep existing dependencies)`
`// ... existing error handling ...`  
`// ... rest of the component ...`
`// ... (previous dependencies)`
`// ... (previous code)`
`// ... (previous values)`
`// ... (rest of the file)`




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
- [x] output generation to be modular (maybe buffer like mechanics)
- [x] grouping :equal, :insert, :deleted directives...
- [ ] JS frontend for a merge tool
- [ ] Integrative new diff handling... Sort of handling the streamed chunked input in - the changes...
- [ ] Testing if it handles consecutive diffs properly
- [ ] whitespace "ignore" sort of
- [ ] Testing testing testing...
- [ ] LCS + consecutiveity support... So if it finds 2,1,1 in a large text it is worse then finding the 4 consecutive line. (Btw... this should be found most of the time simply because ... tldw)
- [ ] Speed measureing... If it isn't infinitly fast...

## How was this created?
By AI (70-90% and this is just the beginning)... used the tool [AISH.jl](https://github.com/Cvikli/AISH.jl)
