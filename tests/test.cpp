#include "gtest/gtest.h"

TEST(VanillaTest, ExampleTest)
{
    ASSERT_EQ(1, 1);
}

int main(int argc, char* argv[]) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}