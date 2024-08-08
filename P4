/*
Link: https://codeforces.com/contest/889/problem/E


Julie has a sequence of integers `a1, a2, ..., an`. Let `f(x, i) = (ai + x) % ai+1`, and for `1 ≤ i < n`. Here, `%` denotes the modulus operation. 
Julie wants to find the maximum value of `f(x, 1)` over all nonnegative integers `x`.

Input:
You are given a 0 indexed vector  `values` (1 ≤ values[i] ≤ 10^13) — the elements of the sequence.

Output:
Return a single integer — the maximum value of `f(x, 1)` over all nonnegative integers `x`.

Create a C++ Function `DeliverPackages` that will return an integer denoting the minimum number of trips required. 
Use appropriate Error Handling using the `stdexcept` library for the invalid test cases.

Input Type:

 vector<long long> denoting values


Input Constraints:
 The length of `values` should be at least 1 and at most 200,000 inclusive.
 Each value in `values` should be a positive integer within the range [1, 10^13].


*/

#include <iostream>
#include <vector>
#include <algorithm>
#include <stdexcept>
#include <cassert>

long long DeliverPackages(std::vector<long long>& elements) {
  
   long long length = elements.size();
  
    if (length < 1 || length > 200000) {
        throw std::invalid_argument("Length out of bounds");
    }
    
    for (const long long& element : elements) {
        if (element < 1 || element > 1e13) {
            throw std::invalid_argument("Element out of bounds");
        }
    }
    
    std::vector<long long> min_elements(length + 1);
    std::vector<long long> max_values(length + 1, 0);
    
    for (long long i = length; i >= 1; --i) {
        min_elements[i] = elements[length - i];
    }
    min_elements[0] = 1;
    
    for (long long i = length - 1; i >= 1; --i) {
        min_elements[i] = std::min(min_elements[i], min_elements[i + 1]);
    }
    
    for (long long i = 1; i <= length; ++i) {
        long long current_sum = 0;
        long long sum_increments = 0;
        
        for (long long j = min_elements[i]; j >= 1; j %= min_elements[current_sum]) {
            current_sum = std::lower_bound(min_elements.begin() + 1, min_elements.begin() + length + 1, j) - min_elements.begin() - 1;
            max_values[i] = std::max(max_values[i], max_values[current_sum] + (length - current_sum) * (j - j % min_elements[current_sum] - min_elements[current_sum]) + sum_increments);
            sum_increments += (length - current_sum) * (j - j % min_elements[current_sum]);
        }
    }
    return max_values[length];
}

#include <iostream>
#include <vector>
#include <algorithm>
#include <stdexcept>
#include <cassert>

int main() {
   //TEST
std::vector<long long> elements_1 = {1, 2, 3, 4, 5};
long long expected_1 = 0; 
long long result_1 = DeliverPackages(elements_1);
assert(result_1 == expected_1);
//TEST_END

//TEST
std::vector<long long> elements_2 = {10, 20, 30, 40, 50};
long long expected_2 = 45; 
long long result_2 = DeliverPackages(elements_2);
assert(result_2 == expected_2);
//TEST_END

//TEST
std::vector<long long> elements_3 = {5, 5, 5, 5, 5};
long long expected_3 = 20;
long long result_3 = DeliverPackages(elements_3);
assert(result_3 == expected_3);
//TEST_END

//TEST
std::vector<long long> elements_4 = {100, 200, 300, 400, 500};
long long expected_4 = 495; 
long long result_4 = DeliverPackages(elements_4);
assert(result_4 == expected_4);
//TEST_END

//TEST
std::vector<long long> elements_5 = {1, 1, 1, 1, 1};
long long expected_5 = 0; 
long long result_5 = DeliverPackages(elements_5);
assert(result_5 == expected_5);
//TEST_END

//TEST
std::vector<long long> elements_6 = {1000000000000, 1000000000000, 1000000000000};
long long expected_6 = 2999999999997; // hypothetical expected result
long long result_6 = DeliverPackages(elements_6);
assert(result_6 == expected_6);
//TEST_END

//TEST
std::vector<long long> elements_7 = {987654321, 123456789, 987654321, 123456789};
long long expected_7 = 1358024675; 
long long result_7 = DeliverPackages(elements_7);
assert(result_7 == expected_7);
//TEST_END

//TEST
std::vector<long long> elements_8 = {1, 10, 100, 1000, 10000, 100000};
long long expected_8 =0;
long long result_8 = DeliverPackages(elements_8);
assert(result_8 == expected_8);
//TEST_END

//TEST
std::vector<long long> elements_9 = {2, 4, 6, 8, 10};
long long expected_9 = 5; 
long long result_9 = DeliverPackages(elements_9);
assert(result_9 == expected_9);
//TEST_END


//TEST
std::vector<long long> elements_10 = {}; 
try {
DeliverPackages(elements_10);
assert(false); 
} catch (const std::invalid_argument& e) {
assert(true); 
}
//TEST_END

//TEST
std::vector<long long> elements_11 = {0}; 
try {
DeliverPackages(elements_11);
assert(false); 
} catch (const std::invalid_argument& e) {
assert(true); 
}
//TEST_END

//TEST
std::vector<long long> elements_12 = {1, 10000000000001}; 
try {
DeliverPackages(elements_12);
assert(false); 
} catch (const std::invalid_argument& e) {
assert(true); 
}
//TEST_END

//TEST
std::vector<long long> elements_13 = {-1, 2, 3}; 
try {
DeliverPackages(elements_13);
assert(false); 
} catch (const std::invalid_argument& e) {
assert(true); 
}
//TEST_END

//TEST
std::vector<long long> elements_14 = {0, 2, 3};
try {
DeliverPackages(elements_14);
assert(false); 
} catch (const std::invalid_argument& e) {
assert(true); 
}
//TEST_END
    //TEST
std::vector<long long> elements_15 = {1, 2, -3};
try {
DeliverPackages(elements_15);
assert(false);
} catch (const std::invalid_argument& e) {
assert(true); 
}
//TEST_END



    return 0;
}
