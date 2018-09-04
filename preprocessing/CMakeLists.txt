
add_tinytest_executable(date_guard date_guard.cpp)
set_target_properties(date_guard
    PROPERTIES
    CXX_STANDARD 14)
add_test(
    NAME
    "preprocessing::date-guard"
    COMMAND
    date_guard
)