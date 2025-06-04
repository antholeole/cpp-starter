#include <gtest/gtest.h>

#include "lib.hh"

TEST(LibTest, Add) { EXPECT_EQ(add(10, 12), 22); }
