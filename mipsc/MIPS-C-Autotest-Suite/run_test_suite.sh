#!/usr/bin/env bash

# Declare the file paths
MY_FILE_PATH='./mipsc'
SOLUTION_PATH='1521 mipsc'

# Declare our colour codes
red="\e[0;31m"
green="\e[0;32m"
reset="\e[0m"

# Show that command is running
echo -e $reset"Running autotests for mipsc.c"

# First compile the file
echo 'dcc mipsc.c -o mipsc'
dcc mipsc.c -o mipsc

# Keep track of number of tests passed and failed
let num_tests=1
let num_passed=0
let num_failed=0

# Run through autotests
for test_file in $(find . -name "*hex"); do
    $MY_FILE_PATH $test_file 1>your_out.tmp 2>your_err.tmp
    $SOLUTION_PATH $test_file 1>exp_out.tmp 2>exp_err.tmp

    passed="Test $num_tests ($test_file $MY_FILE_PATH) -$green passed$reset"
    failed="Test $num_tests ($test_file $MY_FILE_PATH) -$red failed$reset"

    if diff -q your_err.tmp exp_err.tmp >/dev/null; then
        # Output to stderr is correct
        if diff -q your_out.tmp exp_out.tmp >/dev/null; then
            # Output to stdout is correct
            echo -e "$passed"
            let num_passed++
        else
            # Output to stdout is incorrect
            echo -e "$failed\nYour program's output to stdout is incorrect."
            diff --color -u your_out.tmp exp_out.tmp
            let num_failed++
        fi
    else
        # Output to stderr is incorrect
        echo -e "$failed\nYour program's output to stderr is incorrect."
        diff --color -u your_err.tmp exp_err.tmp
        let num_failed++
    fi
    let num_tests++

    # Delete tmp files while hiding output
    rm your_out.tmp your_err.tmp exp_out.tmp exp_err.tmp >/dev/null 2>&1

    $MY_FILE_PATH -r $test_file 1>your_out.tmp 2>your_err.tmp
    $SOLUTION_PATH -r $test_file 1>exp_out.tmp 2>exp_err.tmp

    passed="Test $num_tests ($test_file -r $MY_FILE_PATH) -$green passed$reset"
    failed="Test $num_tests ($test_file -r $MY_FILE_PATH) -$red failed$reset"

    if diff -q your_err.tmp exp_err.tmp >/dev/null; then
        # Output to stderr is correct
        if diff -q your_out.tmp exp_out.tmp >/dev/null; then
            # Output to stdout is correct
            echo -e "$passed"
            let num_passed++
        else
            # Output to stdout is incorrect
            echo "$failed\nYour program's output to stdout is incorrect."
            diff --color -u your_out.tmp exp_out.tmp
            let num_failed++
        fi
    else
        # Output to stderr is incorrect
        echo "$failed\nYour program's output to stderr is incorrect."
        diff --color -u your_err.tmp exp_err.tmp
        let num_failed++
    fi
    let num_tests++

    # Delete tmp files while hiding output
    rm your_out.tmp your_err.tmp exp_out.tmp exp_err.tmp >/dev/null 2>&1
done

if [ $num_failed = 0 ]; then
    echo -e "$green$num_passed tests passed $num_failed tests failed$reset"
elif [ $num_passed = 0 ]; then
    echo -e "$red$num_passed tests passed $num_failed tests failed$reset"
else
    echo -e "$green$num_passed tests passed $red$num_failed tests failed$reset"
fi

rm mipsc