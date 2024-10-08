using Revise
using RelevanceStacktrace
using DiffLib

# content1 = read("test_cases/test_file.jl", String)
# content2 = read("test_cases/test_file.changes.jl", String)
# content1 = read("src/DiffLib.jl", String)
# content2 = read("test_cases/extreme.jl", String)

println("-----------------")

# word_diff_with_wildcard(alines, blines, "WILDCARD", true)
# diff_files("src/lcs.jl", "test_cases/delta.jl", ["// ... existing code ...", "// ... rest of the existing code ..."], print_output=true)
# diff_files("src/lcs.jl", "test_cases/delta.jl", "// ...", print_output=true)
diff_files("test_cases/case1.js", "test_cases/case1_changes.js", "// ...", print_output=true)
# res, is_weak_match = diff_files("test_cases/case2.js", "test_cases/case2_changes.js", "// ...", print_output=true)

;
#%%
res,_ =diff_files("test_cases/case1.js", "test_cases/case1_changes.js")
#%%
res, _ = diff_files("test_cases/server.jl", "test_cases/server.changes2.jl", print_output=true)
#%%
display(res)
#%%
println(res[1])
#%%
res
#%%
using DiffLib: compact_diff_result
[println("$a\n($i)\n($j)") for (a,i,j) in (res)];
#%%
compact_diff_result(res)
#%%

res, is_weak_match = diff_files("test_cases/case2.js", "test_cases/case2_final.js", print_output=true)



;
#%%
res, is_weak_match = diff_files("test_cases/case0.js", "test_cases/case0_changes.js", "// ...", print_output=true)
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

