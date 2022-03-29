

#include <stdio.h>
#include "unity.h"
#include "library.h"

void setUp(void)
{
  // set stuff up here
}

void tearDown(void)
{
  // clean stuff up here
}

void test_function_should_pass(void)
{
  TEST_ASSERT_EQUAL(0, 0);
}

void test_function_should_fail(void)
{
  TEST_ASSERT_EQUAL(0, 1);
}

void test_function_add(void)
{
  TEST_ASSERT_EQUAL(42, add(40, 2));
  TEST_ASSERT_EQUAL(40, add(40, 0));
  TEST_ASSERT_EQUAL(30, add(40, -10));
  TEST_ASSERT_EQUAL(0, add(0, 0));
}

int main(void)
{
  printf("Running Tests...\n");
  UNITY_BEGIN();
  RUN_TEST(test_function_should_pass);
  // RUN_TEST(test_function_should_fail);
  RUN_TEST(test_function_add);
  return UNITY_END();
}
