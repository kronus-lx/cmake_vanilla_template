# CMAKE VANILLA PROJECT

The above project is an example template for creating new C/C++ projects and building using the cmake build system.
The project provides a basic set of scripts to successful quickstart a C/C++ project with the following dependencies:

 - Boost Libraries
 - Gtest Unit Testing Framework
 
To demonstate the how a successful project should be setup and created example exe, and library projects have been provided.
This project should be used in the context of modifying depending on the requirements to the project and should be used as a guide and not a one size fits all approach.

For Windows builds, a CMakeSettings.json has been provided with variables to be modified where the latest Git repository for GTest can be found, the local windows toolchain, and location for boost. For Linux users these variables will have to be included mannually when setting up your project, for example:

    cmake ../ -DGTEST_REPOSITORY=https://github.com/google/googletest.git -DBOOST_REQUIRED=true

# Boost

For boost to be successfully included in the project it must firstly be installed on the target machine, for windows it is advised boost is installed via vcpkg and its respective toolchain included as part of the project.  On Linux it is advised the lastest source is pulled and built on the target machine.