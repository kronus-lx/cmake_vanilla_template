#pragma once

#include <sstream>
#include <string>
#include <string_view>

namespace Shape
{
	class Shape {
		public:
			virtual ~Shape() noexcept {};
	};

	namespace Coordinate
	{
		struct Point {
			
			double x;
			
			double y;

			Point() = default;

			Point(double in_x, double in_y)  :x(in_x), y(in_y) {}

			void assign(const Coordinate::Point& p){
				x = p.x;
				y = p.y;
			}

			constexpr bool is_same(Coordinate::Point& p) const {
				return (x == p.x && y == p.y);
			}
		};
	}

	class Rectangle : public Shape {
		private:
			Coordinate::Point p1;
			Coordinate::Point p2;
			mutable std::string coordinate_str;
		public:
			Rectangle() : p1(0.0, 0.0), p2(0.0, 0.0) {};
			
			Rectangle(const Coordinate::Point& co_p1, const Coordinate::Point& co_p2) :
				p1(co_p1), p2(co_p2){}

			std::string_view coordinates_display() const {
				std::stringstream ss;
				ss << p1.x << "," << p1.y << ","
					<< p2.x << "," << p2.y << "\n";
				
				coordinate_str = ss.str();
				
				return coordinate_str;
			}

			~Rectangle() noexcept {}
	};
}