cmake_minimum_required(VERSION 3.20)

# Set the required policy
if(POLICY CMP0148)
	cmake_policy(SET CMP0148 NEW)
endif()

# Select the components required from Boost
set(BOOST_COMPONENTS json coroutine)

# Define a function to find or install Boost
function(find_or_install_boost)
    find_package(Boost REQUIRED COMPONENTS ${BOOST_COMPONENTS})
    if(NOT Boost_FOUND)
        message(STATUS "Boost not found. Downloading and installing Boost...")
        if(WIN32)
            set(BOOST_URL "https://boostorg.jfrog.io/artifactory/main/release/1.85.0/source/boost_1_85_0_rc3.zip")
            set(BOOST_ARCHIVE "boost_1_85_0.zip")
            set(BOOST_DIR "C:\\Program Files (x86)\\boost_1_85_0")
            file(DOWNLOAD ${BOOST_URL} ${BOOST_ARCHIVE})
            execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${BOOST_ARCHIVE} WORKING_DIRECTORY C:/)
        else()
            set(BOOST_URL "https://boostorg.jfrog.io/artifactory/main/release/1.85.0/source/boost_1_85_0_rc3.tar.gz")
            set(BOOST_ARCHIVE "boost_1_85_0.tar.gz")
            set(BOOST_DIR "/usr/local/boost_1_85_0")
            file(DOWNLOAD ${BOOST_URL} ${BOOST_ARCHIVE})
            execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${BOOST_ARCHIVE} WORKING_DIRECTORY /usr/local)
        endif()

        find_package(Boost REQUIRED COMPONENTS ${BOOST_COMPONENTS})
 
    endif()

    # Link Directories and Libraries to Boost
    message(STATUS ">> BOOST ROOT ${BOOST_ROOT}")
    message(STATUS ">> BOOST FOUND! ${Boost_VERSION}")
    message(STATUS ">> BOOST LIBRARIES: ${Boost_LIBRARIES}")
    message(STATUS ">> BOOST DIRECTORIES: ${Boost_INCLUDE_DIRS}")
    message(STATUS ">> BOOST LIBRARIES DIR : ${Boost_LIBRARY_DIRS}")

    include_directories(${Boost_INCLUDE_DIRS})
    link_directories(${Boost_LIBRARY_DIRS})
    

endfunction()