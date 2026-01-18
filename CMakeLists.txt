cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    Qameleon
    VERSION 0.1.0
    DESCRIPTION "Qt UI Framework with A ThemeEngine."
    HOMEPAGE_URL "https://github.com/gemone/Qameleon"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)
include(cmake/local-qt6.cmake)

# ---- Declare library ----

add_library(
    Qameleon_Qameleon
    source/Qameleon.cpp
)
add_library(Qameleon::Qameleon ALIAS Qameleon_Qameleon)

include(GenerateExportHeader)
generate_export_header(
    Qameleon_Qameleon
    BASE_NAME Qameleon
    EXPORT_FILE_NAME export/Qameleon/Qameleon_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(Qameleon_Qameleon PUBLIC QAMELEON_STATIC_DEFINE)
endif()

set_target_properties(
    Qameleon_Qameleon PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME Qameleon
    OUTPUT_NAME Qameleon
)

target_include_directories(
    Qameleon_Qameleon ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    Qameleon_Qameleon SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(Qameleon_Qameleon PUBLIC cxx_std_20)

# ---- Dependencies ----
# Find Qt6 using custom function from local-qt6.cmake
# Qt6 will always be linked as shared libraries regardless of BUILD_SHARED_LIBS
qameleon_find_qt6(COMPONENTS Core Gui)
target_link_libraries(Qameleon_Qameleon PUBLIC ${QT_TARGETS})

find_package(fmt REQUIRED)
target_link_libraries(Qameleon_Qameleon PRIVATE fmt::fmt)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${Qameleon_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT Qameleon_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of Qameleon"
  )
endif()

include(cmake/dev-mode.cmake)
