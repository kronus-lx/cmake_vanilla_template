include(FetchContent)

FetchContent_Declare(
	googletest
	GIT_REPOSITORY ${GTEST_REPOSITORY}
	GIT_TAG release-1.10.0
)

FetchContent_MakeAvailable(googletest)

add_library(GTest::GTest INTERFACE IMPORTED)

# Target sources at the exe
target_sources(
	all_tests PRIVATE "test.cpp"
)

target_include_directories(${TEST_APPLICATION} PRIVATE "${gtest_SOURCE_DIR}/include")

# Link the Libraries from 
target_link_libraries(GTest::GTest INTERFACE gtest_main)

# Target if debug or not
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_link_libraries(${TEST_APPLICATION} PRIVATE gtestd)
else()
    target_link_libraries(${TEST_APPLICATION} PRIVATE gtest gtest_main)
endif()