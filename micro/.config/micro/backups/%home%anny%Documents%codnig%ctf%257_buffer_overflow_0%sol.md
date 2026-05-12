# Challenge 433: buffer overflow 0

### how flag gets printed:
- *line 11*: there's a `printf` statement for the flag

### vulnerability
- `vuln()` function has only a size 16 buffer while we are using size 100 buffer for `gets` in *line 40*
- we can exploit this by spamming when asked for input.

### flag
picoCTF{ov3fl0ws_ar3nt_that_bad_ef01832d}
