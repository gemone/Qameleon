unset(Qt6_DIR CACHE)
# please add QT6_PATH to UserPresets or variables
list(APPEND CMAKE_PREFIX_PATH "${LOCAL_QT6_PATH}")

# Function to find and configure Qt6 with specified components
# Usage: qameleon_find_qt6(COMPONENTS Core Gui Widgets ...)
function(qameleon_find_qt6)
    cmake_parse_arguments(ARG "" "" "COMPONENTS" ${ARGN})
    
    if(NOT ARG_COMPONENTS)
        message(FATAL_ERROR "qameleon_find_qt6: No COMPONENTS specified")
    endif()
    
    # Find Qt6 with required components
    find_package(Qt6 REQUIRED COMPONENTS ${ARG_COMPONENTS})
    message(STATUS "Found Qt6: ${Qt6_DIR}")
    message(STATUS "Qt6 Components: ${ARG_COMPONENTS}")
    
    # Generate Qt6 target names
    set(QT_TARGETS "")
    foreach(component ${ARG_COMPONENTS})
        list(APPEND QT_TARGETS Qt6::${component})
    endforeach()
    
    # Export to parent scope
    set(QT_TARGETS ${QT_TARGETS} PARENT_SCOPE)
    set(QT_COMPONENTS ${ARG_COMPONENTS} PARENT_SCOPE)
endfunction()