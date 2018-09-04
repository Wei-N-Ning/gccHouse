#include <iostream>

// see:
// https://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html

int main() {
    std::cout << __FILE__ << std::endl;
    std::cout << __LINE__ << std::endl;
    std::cout << __DATE__ << std::endl;
    std::cout << __TIME__ << std::endl;

    return 0;
}
