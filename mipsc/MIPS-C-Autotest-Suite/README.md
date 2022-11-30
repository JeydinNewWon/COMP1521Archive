# MIPS-C-Autotest-Suite

Autotest suite for `MIPS-C` (COMP1521 22T3 Assignment 2)

## How to use

Start by either cloning this repository or downloading it as a zip and unzipping it in the directory with your `mipsc.c` file.
Once you've done that, simply navigate to your working directory in the bash terminal and run the script with `bash MIPS-C-Autotest-Suite/run_test_suite.sh`.

You can also give the script execute permission by using `chmod +x MIPS-C-Autotest-Suite/run_test_suite.sh` to be able to run it with `./MIPS-C-Autotest-Suite/run_test_suite.sh`.

Please note that you should be on the CSE servers before attempting to run the script, as it requires access to the reference solution!

## Contents of Repo

- `run_test_suite.sh` is the bash script to execute, which will use all the `.hex` files found recursively in your working directory as input to the `mipsc` program.
- `tests/` is a directory containing the test cases.
  - Each test case is a `.hex` file containing the inputs to the program.

## Things to note

The autotest script doesn't check for invalid instructions properly.
It attempts to match both `stdout` and `stderr` against the reference implementation, although the specs note that any outputs to `stdout` should be ignored if the program halts due to an invalid instruction.

**This is not checked correctly!**

If you have a failed test for `invalid_instruction.hex` with the note that your `stdout` output is incorrect, please ignore!

## Suggestions

If you have suggestions for more test cases, please ping (in the CSESOC #1521 channel) or DM me on discord!
My discord handle is MysticalFire#2217.

## Credits

Thanks to these amazing people for helping to come up with tests!

- natisV#3704
  - `div_by_zero.hex`
  - `invalid_instruction.hex`
- shinybuncis#6996
  - `lui_neg.hex`
  - `slt_neg.hex`
  - `signed_int_overflow.hex` (not a case we must handle - see specs)
- Jamo#2849
  - `branching.hex`
  - `sub.hex`
  - `sub_neg.hex`
- Joltik#4436
  - `many_zeroes.hex`
  - `div_by_zero_extend.hex`
