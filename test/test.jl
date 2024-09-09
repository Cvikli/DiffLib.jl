using Revise
using RelevanceStacktrace
using DiffLib: diff_files

# content1 = read("test/archive/test_file.jl", String)
# content2 = read("test/archive/test_file.changes.jl", String)
# content1 = read("src/DiffLib.jl", String)
# content2 = read("test/archive/extreme.jl", String)

println("-----------------")

# word_diff_with_wildcard(alines, blines, "WILDCARD", true)
# diff_files("src/lcs.jl", "test/archive/delta.jl", ["// ... existing code ...", "// ... rest of the existing code ..."], print_output=true)
# diff_files("src/lcs.jl", "test/archive/delta.jl", "// ...", print_output=true)
diff_files("test/archive/case1.js", "test/archive/case1_changes.js", "// ...", print_output=true)
# res, is_weak_match = diff_files("test/archive/case2.js", "test/archive/case2_changes.js", "// ...", print_output=true)

;
#%%

res, is_weak_match = diff_files("test/archive/case2.js", "test/archive/case2_final.js", print_output=true)



;
#%%
res, is_weak_match = diff_files("test/archive/case0.js", "test/archive/case0_changes.js", "// ...", print_output=true)
;
#%%
using DiffLib: format_diff
println(format_diff(res))

#%%
using DiffLib: format_diff
println(format_diff(res))
#%%
res
#%%
using JET

res = report_package("DiffLib")


#%%
println(res)
#%%

using InteractiveUtils

@code_warntype word_diff_with_wildcard(alines, blines, ["// ... existing code ...", "// ... rest of the existing code ..."], true)

