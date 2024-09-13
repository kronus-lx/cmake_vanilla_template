cmake_minimum_required(VERSION 3.20)
project(example LANGUAGES CXX C)

# Set the location where custom CMake scripts are written
set(CUSTOM_SCRIPTS "${PROJECT_SOURCE_DIR}/scripts")

# Override the potential errors caused by gtest
set(gtest_disable_pthreads ON) # If you're using pthreads

# For MSVC compilation
if(MSVC)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

# Enable Testing --> This is a must for testing your libaries
enable_testing() 

# Send Messages to the console with the output of variables
message(STATUS ">> IS BOOST REQUIRED : ${BOOST_REQUIRED}")
message(STATUS ">> WINDOWS TOOLCHAIN : ${WINDOWS_DEPENDENCY_TOOLCHAIN}")
message(STATUS ">> GTEST REPOSITORY  : ${GTEST_REPOSITORY}")

# Handle the Requirement for Boost
if(BOOST_REQUIRED)
    include("${CUSTOM_SCRIPTS}/InstallBoostCustom.cmake")
    message(STATUS ">> BOOST REQUIRED SETTING FLAG")
    option(USE_BOOST "Use the Boost Library" ON)
endif()

# Handle the Configuration of the Boost Dependencies
if(USE_BOOST)
    set(Boost_USE_STATIC_LIBS OFF)
    if(MSVC)
        set(CMAKE_TOOLCHAIN_FILE ${WINDOWS_DEPENDENCY_TOOLCHAIN})
    endif()

    message(STATUS "LOOKING FOR BOOST ON SYSTEM ..... ")
    # Use installation script for Boost
    find_or_install_boost()
endif()

# Setup Macros for targets
set(MAIN_APPLICATION app)
set(TEST_APPLICATION all_tests)
set(LIBRARY_BIN example)
set(HEADER_LIBRARY shape)

# Add Executable and Library
add_executable(${MAIN_APPLICATION})
add_executable(${TEST_APPLICATION})
add_library(${LIBRARY_BIN} SHARED)
add_library(${HEADER_LIBRARY} INTERFACE)

# Allows for relative path to subdirectories headers and pulled dependencies
target_include_directories(${MAIN_APPLICATION} PRIVATE ${PROJECT_SOURCE_DIR})
target_include_directories(${TEST_APPLICATION} PRIVATE ${PROJECT_SOURCE_DIR})
target_include_directories(${LIBRARY_BIN} PRIVATE ${Boost_INCLUDE_DIRS})
target_include_directories(${MAIN_APPLICATION} PRIVATE ${Boost_INCLUDE_DIRS})

# Set the standard to compile to for the executables
target_compile_features(${MAIN_APPLICATION} PRIVATE cxx_std_20)
target_compile_features(${TEST_APPLICATION} PRIVATE cxx_std_20)
target_compile_features(${LIBRARY_BIN} PRIVATE cxx_std_20)

# Add Subdirectories
add_subdirectory(letters)
add_subdirectory(nums)
add_subdirectory(shape)
add_subdirectory(tests)

unset(Boost_LIBRARIES)
set(Boost_USE_STATIC ON)
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME ON)

# Target Source Files
target_sources(${MAIN_APPLICATION} PRIVATE "app.cpp")

# To tell CMake that app is dependent on the library we are creating
add_test(all_tests_gtest ${TEST_APPLICATION})

# Link Libraries Required by each project
# Examples Being JSON and coroutine can be any boost library
# When linking against boost dependencies make sure that they are listed here otherwise not
if(USE_BOOST)
    target_link_libraries(${MAIN_APPLICATION} PRIVATE ${LIBRARY_BIN} ${HEADER_LIBRARY} Boost::json Boost::coroutine)
    target_link_libraries(${LIBRARY_BIN} PRIVATE Boost::json Boost::coroutine)
    target_link_libraries(${TEST_APPLICATION} PRIVATE ${HEADER_LIBRARY} ${LIBRARY_BIN})
else()
    target_link_libraries(${MAIN_APPLICATION} PRIVATE ${LIBRARY_BIN} ${HEADER_LIBRARY})
    target_link_libraries(${TEST_APPLICATION} PRIVATE ${HEADER_LIBRARY} ${LIBRARY_BIN}) 
endif()

# Install rules for different configurations
install(TARGETS ${MAIN_APPLICATION}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
    CONFIGURATIONS Debug Release
)

# install all targets associated with the libaray application
install(TARGETS ${LIBRARY_BIN} 
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
    CONFIGURATIONS Debug Release
)

# Install all targets associated with the test application
install(TARGETS ${TEST_APPLICATION} 
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
    CONFIGURATIONS Debug Release
)

# Install Library
install(TARGETS ${LIBRARY_BIN} FILE_SET HEADERS)
# Install Header Library
install(TARGETS ${HEADER_LIBRARY} FILE_SET HEADERS)