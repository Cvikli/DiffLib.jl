# DiffLib.jl
Creating diff that supports wildcard produced by LLMs


# TODO
- [x] File path handling
- [x] File readall string handling
- [x] ARGS handling
- [x] Refactor to use indexes
- [x] Typesafety check
- [ ] Word based diff
- [ ] Even character based diff
- [ ] find best match should be keeping the order to verify the match. Also should be - whitespace sensitive probably. Also LCS could be used here too to check matching - line by line.
- [ ] Create README.md
- [ ] Integrative new diff handling... Sort of handling the streamed chunked input in - the changes...
- [x] multi wildcard handling in typesafe manner ;)
- [ ] output generation to be modular
- [ ] JS frontend for a merge tool
- [ ] Handling consecutive diffs properly
- [ ] Speed measureing... If it isn't infinitly fast...