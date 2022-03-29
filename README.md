# TestingWithUnity
a simple demonstration of testing C with the Unity test framework

To build the program:

make main

To build and run the tests:

make test

Typical test results (created in build/results):


-----------------------IGNORES:-----------------------

-----------------------FAILURES:-----------------------
test/Testlibrary.c:24:test_function_should_fail:FAIL: Expected 0 Was 1
FAIL
-----------------------PASSED:-----------------------
test/Testlibrary.c:39:test_function_should_pass:PASS
test/Testlibrary.c:41:test_function_add:PASS
DONE
