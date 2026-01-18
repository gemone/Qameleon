set(Qameleon_FOUND YES)

include(CMakeFindDependencyMacro)
find_dependency(fmt)

if(Qameleon_FOUND)
  include("${CMAKE_CURRENT_LIST_DIR}/QameleonTargets.cmake")
endif()
