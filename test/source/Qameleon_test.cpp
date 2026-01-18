#include <string>

#include "Qameleon/Qameleon.hpp"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Name is Qameleon", "[library]")
{
  auto const exported = exported_class {};
  REQUIRE(std::string("Qameleon") == exported.name());
}
