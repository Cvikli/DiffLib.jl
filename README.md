# DiffLib.jl
Creating diff that supports wildcard produced by LLMs


# TODO
- [ ] File path handling
- [ ] File readall string handling
- [ ] Refactor to use indexes
- [ ] Typesafety check
- [ ] Integrative new diff handling... Sort of handling the streamed chunked input in - the changes...
- [ ] Speed measureing... If it isn't infinitly fast...
- [ ] Word based diff
- [ ] Even character based diff
- [ ] find best match should be keeping the order to verify the match. Also should be - whitespace sensitive probably. Also LCS could be used here too to check matching - line by line.
- [ ] Handling consecutive diffs properly
- [ ] output generation to be modular
- [ ] JS frontend for a merge tool
- [ ] multi wildcard handling in typesafe manner ;)