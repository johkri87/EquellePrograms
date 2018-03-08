cmake_minimum_required (VERSION 2.8.11)
project (MyPrograms)

find_package(CUDA REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(Boost REQUIRED COMPONENTS unit_test_framework)
find_package( Equelle REQUIRED )


# We need C++14 features.
if(NOT MSVC)
	set( CMAKE_CXX_FLAGS "-std=c++14 -Wall -Wextra ${CMAKE_CXX_FLAGS}")
endif()


include("../releaseconf.cmake")


link_directories(
  ${EQUELLE_LIB_DIRS}
  ${EQUELLE_EXTRA_LIB_DIRS}
)

file( GLOB app_sources "CompiledSrc/*.cpp" )

# --- Stuff for making non-source code show up in IDEs

file( GLOB_RECURSE EQUELLE_README "README.*" )
file( GLOB_RECURSE EQUELLE_EXAMPLE_SOURCES "*.equelle" )
source_group( "Assets" FILES ${EQUELLE_README} ${EQUELLE_EXAMPLE_SOURCES} ${EQUELLE_VAGRANT} )
add_custom_target( Equelle_EXAMPLES_DEPS SOURCES ${EQUELLE_README} ${EQUELLE_EXAMPLE_SOURCES} )

file( GLOB sources     "CompiledSrc/*.cpp" )
file( GLOB headers     "include/*.hpp" )
#file( GLOB DSL_sources "dsl/*.equelle" )
file( GLOB cuda_files  "src/*.cu" )
file( GLOB cuda_include "cuda_include/*.hpp" )

include_directories( ${EQUELLE_INCLUDE_DIRS} ${EQUELLE_EXTRA_INCLUDE_DIRS} )

foreach( app ${app_sources} )
  get_filename_component( target ${app} NAME_WE )

  add_executable( ${target}
  	${app} ${headers} ${DSL_sources}
    )

  target_link_libraries( ${target}
    ${EQUELLE_LIBRARIES}
    ${EQUELLE_EXTRA_LIBS}
  )
endforeach()