import 'package:flutter/foundation.dart';
import 'package:course/model/course.dart';

class CoursesViewModel extends ChangeNotifier {
  List<Course> _courses = [];
  List<Course> _filteredCourses = [];

  List<Course> get courses =>
      _filteredCourses.isEmpty ? _courses : _filteredCourses;
  List<Course> get cart => _cart;
  List<Course> get favorites => _favorites;

  List<Course> _cart = [];
  List<Course> _favorites = [];

  Future<void> fetchCourses() async {
    _courses = await fetchCoursesFromServer();
    _filteredCourses = [];
    notifyListeners();
  }

  Future<List<Course>> fetchCoursesFromServer() async {
    // Replace with your actual fetching logic
    // This is just a dummy example
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }

  void filterCourses(String query) {
    if (query.isEmpty) {
      _filteredCourses = [];
    } else {
      _filteredCourses = _courses
          .where((course) =>
              course.title.toLowerCase().contains(query.toLowerCase()) ||
              course.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  void addToCart(Course course) {
    _cart.add(course);
    notifyListeners();
  }

  void removeFromCart(Course course) {
    _cart.remove(course);
    notifyListeners();
  }

  void addToFavorites(Course course) {
    _favorites.add(course);
    notifyListeners();
  }

  void removeFromFavorites(Course course) {
    _favorites.remove(course);
    notifyListeners();
  }
}
