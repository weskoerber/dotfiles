#!/usr/bin/zsh

PASSED=0
FAILED=0
TOTAL=0

. $(dirname $0)/../zsh/utils.sh

# $1: Test name
# $2: Expected result
# $3: Actual result
# $4: Message
test_runner() {
    echo "--------------------------------------------------------------------------------"
    TOTAL=$((TOTAL + 1))
    if [ "$2" = "$3" ]; then
        echo "\033[32;1;4mPASS\033[0m: $1\n  $4\n"
        PASSED=$((PASSED + 1))
    else
        echo "\033[31;1;4mFAIL\033[0m: $1\n  $4\n  EXPECTED: $2\n  ACTUAL  : $3\n\n"
        FAILED=$((FAILED + 1))
    fi
}

test_dir_exists_works() {
    test_runner $0 "1" $(dir_exists "/some/non-existent/path") "Returns 0 when directory does not exist"
    test_runner $0 "0" $(dir_exists "/usr/bin") "Returns 1 when directory exists"
}

test_file_exists_works() {
    test_runner $0 "1" $(file_exists "/some/non-existent/file") "Returns 0 when file does not exist"
    test_runner $0 "0" $(file_exists "/usr/bin/sh") "Returns 1 when file exists"
}

test_dir_exists_works
test_file_exists_works

echo "--------------------------------------------------------------------------------"
printf "TOTAL: %s    PASSED: %s    FAILED: %s\n" $TOTAL $PASSED $FAILED
echo "--------------------------------------------------------------------------------"

exit $FAILED
