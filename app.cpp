#include <iostream>
#include <string_view>
#include "nums/nums.h"
#include "letters/letters.h"
#include "shape/shape.hpp"
#include "boost/json.hpp"
#include "boost/coroutine/all.hpp"

namespace json = boost::json;

namespace co = boost::coroutines;

void cooperative(co::coroutine<void>::push_type& sink) {
	std::cout << "Hello";
	sink();
	std::cout << "World\n";
}

int main(int argc, char* argv[]) {
	
	number_one();
	
	letter_one();
	
	Shape::Rectangle rec;
	
	json::object jv;

	jv["name"] = "Joel";

	std::cout << jv << "\n";

	std::cout << rec.coordinates_display() << "\n";
	
	co::coroutine<void>::pull_type source{ cooperative };
	
	std::cout << ", ";
	
	source();
	
	std::cout << "!\n";

	return 0;
}