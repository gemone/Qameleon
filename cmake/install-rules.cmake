if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/Qameleon-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
# should match the name of variable set in the install-config.cmake script
set(package Qameleon)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT Qameleon_Development
)

install(
    TARGETS Qameleon_Qameleon
    EXPORT QameleonTargets
    RUNTIME #
    COMPONENT Qameleon_Runtime
    LIBRARY #
    COMPONENT Qameleon_Runtime
    NAMELINK_COMPONENT Qameleon_Development
    ARCHIVE #
    COMPONENT Qameleon_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    Qameleon_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE Qameleon_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(Qameleon_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${Qameleon_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT Qameleon_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${Qameleon_INSTALL_CMAKEDIR}"
    COMPONENT Qameleon_Development
)

install(
    EXPORT QameleonTargets
    NAMESPACE Qameleon::
    DESTINATION "${Qameleon_INSTALL_CMAKEDIR}"
    COMPONENT Qameleon_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
