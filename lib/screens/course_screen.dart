import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:course/model/course.dart';
import 'package:course/screens/login_screen.dart';
import 'package:course/screens/notescreens.dart';
import 'package:course/screens/test_screen.dart';
import 'package:course/view_model/course_view_model.dart';
import 'package:course/widgets/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _fetchCourses();
    });
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchCourses() async {
    await Provider.of<CoursesViewModel>(context, listen: false).fetchCourses();
  }

  void _onSearchChanged() {
    Provider.of<CoursesViewModel>(context, listen: false)
        .filterCourses(_searchController.text);
  }

  void _addCourse(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final imageUrl = _imageUrlController.text;

    if (title.isEmpty ||
        description.isEmpty ||
        price <= 0 ||
        imageUrl.isEmpty) {
      return;
    }

    final newCourse = Course(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );

    Provider.of<CoursesViewModel>(context, listen: false).addCourse(newCourse);

    Navigator.of(context).pop();
  }

  void _showAddCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yangi kurs qo\'shish'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: _descriptionController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                controller: _imageUrlController,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Bekor qilish'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Qo\'shish'),
            onPressed: () => _addCourse(context),
          ),
        ],
      ),
    );
  }

  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Consumer<CoursesViewModel>(
          builder: (ctx, coursesViewModel, child) {
            return ListView.builder(
              itemCount: coursesViewModel.cart.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: coursesViewModel.cart[i].imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(coursesViewModel.cart[i].title),
                  subtitle:
                      Text('\$${coursesViewModel.cart[i].price.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      coursesViewModel.removeFromCart(coursesViewModel.cart[i]);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showFavorites(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Consumer<CoursesViewModel>(
          builder: (ctx, coursesViewModel, child) {
            return ListView.builder(
              itemCount: coursesViewModel.favorites.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: coursesViewModel.favorites[i].imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(coursesViewModel.favorites[i].title),
                  subtitle: Text(
                      '\$${coursesViewModel.favorites[i].price.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      coursesViewModel
                          .removeFromFavorites(coursesViewModel.favorites[i]);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kurslar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => _showCart(context),
          ),
          IconButton(
              icon: const Icon(Icons.light_mode),
              onPressed: () async {
                final thememode = await AdaptiveTheme.getThemeMode();
                if (thememode == AdaptiveThemeMode.dark) {
                  // ignore: use_build_context_synchronously
                  AdaptiveTheme.of(context).setLight();
                } else {
                  AdaptiveTheme.of(context).setDark();
                }
              }),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => _showFavorites(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Qidirish",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Consumer<CoursesViewModel>(
              builder: (ctx, coursesViewModel, child) {
                if (coursesViewModel.courses.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: coursesViewModel.courses.length,
                    itemBuilder: (ctx, i) {
                      final course = coursesViewModel.courses[i];
                      final isFavorite =
                          coursesViewModel.favorites.contains(course);
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: course.imageUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(course.title),
                        subtitle: Text('\$${course.price.toString()}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                coursesViewModel.addToCart(course);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  coursesViewModel.removeFromFavorites(course);
                                } else {
                                  coursesViewModel.addToFavorites(course);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddCourseDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.book),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsScreen()),
                );
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.note),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteScreen()),
                );
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.quiz),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
