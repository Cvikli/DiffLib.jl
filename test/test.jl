using RelevanceStacktrace
using DiffLib: word_diff_with_wildcard

# content1 = read("test/archive/test_file.jl", String)
# content2 = read("test/archive/test_file.changes.jl", String)
# content1 = read("src/DiffLib.jl", String)
# content2 = read("test/archive/extreme.jl", String)
content1 = read("src/lcs.jl", String)
content2 = read("test/archive/delta.jl", String)

println("-----------------")
alines = String.(split(content1, "\n"))
blines = String.(split(content2, "\n"))

# word_diff_with_wildcard(alines, blines, "WILDCARD", true)
word_diff_with_wildcard(alines, blines, ["// ... existing code ...", "// ... rest of the existing code ..."], true)

#%%
using JET

res = report_package("DiffLib")


#%%
println(res)
#%%

using InteractiveUtils

@code_warntype word_diff_with_wildcard(alines, blines, ["// ... existing code ...", "// ... rest of the existing code ..."], true)

