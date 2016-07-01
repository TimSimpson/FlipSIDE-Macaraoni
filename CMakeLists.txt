project(Nnd32 CXX)
cmake_minimum_required(VERSION 2.8)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

find_package(OpenGL REQUIRED)

include_directories(
    src/nnd32
    target
    ${CONAN_INCLUDE_DIRS}
    ${OPENGL_INCLUDE_DIRS})


include(target/macaroni.cmake)

if (MSVC)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd")
endif()

###############################################################################
#  Run Macaroni in Visual Studio
###############################################################################

add_custom_target(
    invoke_macaroni
    COMMAND cavatappi ${CMAKE_CURRENT_LIST_DIR} -g
)

###############################################################################
#  Extra Functions
###############################################################################
add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND})

function(create_exe name src other_libs)
    add_executable(${name} ${src})
    target_link_libraries(${name} ${other_libs}
                          ${OPENGL_LIBRARIES} ${CONAN_LIBS})
endfunction()

function(create_test name src other_libs)
    create_exe(${name} ${src} ${other_libs})
add_test(test_${name} ${EXECUTABLE_OUTPUT_PATH}/bin/${name})
    add_dependencies(check ${name})
endfunction()


###############################################################################
#  Core
###############################################################################

add_library(Lp3NND32
    ${MACARONI_LIBS_Lp3NND32_CPP_FILES}
    ${MACARONI_LIBS_Lp3NND32_SRC_FILES})
set_source_files_properties(
    ${MACARONI_LIBS_Lp3NND32_SRC_FILES}
    PROPERTIES HEADER_FILE_ONLY TRUE)
target_link_libraries(Lp3NND32 ${OPENGL_LIBRARIES})
target_link_libraries(Lp3NND32 ${CONAN_LIBS})

# If project.lua is found, invoke Macaroni. Otherwise ignore for package builds.
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/project.lua")
    add_dependencies(Lp3NND32 invoke_macaroni)
endif()

create_exe(FlipSide target/FlipSide.cpp Lp3NND32)

