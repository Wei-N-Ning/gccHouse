
// note
// //////// FIX THIS!!!!//////
// the example below has a bug - the "day" component consists of two 
// digit the logic will fail

// this use case is inspired by real event at wt
// some product needs to check whether certain functionality is 
// considered deprecated at compile time, i.e.
// if today were 2018-01-01 and the function (or class) must not be 
// used by 2017-12-31, compilation would fail, throwing out meaningful 
// messages
// 
// gcc's built-in __DATE__ macro is perfect for this use case.

// example:
// Sep  4 2018

#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <cassert>

void RunTinyTests();

void test_year() {
    const char* date = __DATE__;
    int year = atoi(date + 7);
    assert(year == 2018);
}

void test_day() {
    const char* date = __DATE__;
    int day = atoi(date + 5);
    assert(day > 0 && day <= 31);
}

void test_month() {
    const char* date = __DATE__;
    char monthStr[4] = { date[0], date[1], date[2], '\0' };
    const char* months[12] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int month = 1;
    for ( const char* m : months ) {
        if (strcmp(monthStr, m) == 0) {
            break;
        }
        month++;
    }
    assert(month > 0 && month <= 12);
}

bool dateNewerThan(int year, int month, int day) {
    const char* date = __DATE__;
    int yearNow = atoi(date + 7);
    char monthStr[4] = { date[0], date[1], date[2], '\0' };
    const char* months[12] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int monthNow = 1;
    for ( const char* m : months ) {
        if (strcmp(monthStr, m) == 0) {
            break;
        }
        monthNow++;
    }
    int dayNow = atoi(date + 5);
    return (year * 1000 + month * 100 + day) <
        (yearNow * 1000 + monthNow * 100 + dayNow);
}

void test_dateNewerThan() {
    assert(dateNewerThan(2018, 8, 31));
    assert(dateNewerThan(2007, 2, 9));
    assert(! dateNewerThan(3018, 8, 31));
}

int main() {
    RunTinyTests();
    return 0;
}
