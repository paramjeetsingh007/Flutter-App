import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'ProductDetailPage.dart'; // Import the product detail page
import 'Recpiedetailpage.dart';  // Import the recipe detail page
import 'UserDetailPage.dart';    // Import the user detail page
import 'PostDetailPage.dart';    // Import the post detail page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];
  List<dynamic> recipes = [];
  List<dynamic> users = [];
  List<dynamic> posts = [];      // Added posts list
  bool isLoadingProducts = true;
  bool isLoadingRecipes = true;
  bool isLoadingUsers = true;
  bool isLoadingPosts = true;    // Added isLoadingPosts

  int currentProductPage = 1;
  int currentRecipePage = 1;
  int limit = 10;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts(page: currentProductPage);
    fetchRecipes(page: currentRecipePage);
    fetchUsers();
    fetchPosts();               // Fetch posts
  }

  Future<void> fetchProducts({int page = 1}) async {
    setState(() {
      isLoadingProducts = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/products?skip=${(page - 1) * limit}&limit=$limit'));
      if (response.statusCode == 200) {
        final List<dynamic> newProducts = jsonDecode(response.body)['products'];
        setState(() {
          products = newProducts;
          isLoadingProducts = false;
        });
      } else {
        _showErrorSnackbar('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching products: $e');
    } finally {
      setState(() {
        isLoadingProducts = false;
      });
    }
  }

  Future<void> fetchRecipes({int page = 1}) async {
    setState(() {
      isLoadingRecipes = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/recipes?skip=${(page - 1) * limit}&limit=$limit'));
      if (response.statusCode == 200) {
        final List<dynamic> newRecipes = jsonDecode(response.body)['recipes'];
        setState(() {
          recipes = newRecipes;
          isLoadingRecipes = false;
        });
      } else {
        _showErrorSnackbar('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching recipes: $e');
    } finally {
      setState(() {
        isLoadingRecipes = false;
      });
    }
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoadingUsers = true;
    });
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/users'));
      if (response.statusCode == 200) {
        final List<dynamic> newUsers = jsonDecode(response.body)['users'];
        setState(() {
          users = newUsers;
          isLoadingUsers = false;
        });
      } else {
        _showErrorSnackbar('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching users: $e');
    } finally {
      setState(() {
        isLoadingUsers = false;
      });
    }
  }

  // Fetch Posts
  Future<void> fetchPosts() async {
    setState(() {
      isLoadingPosts = true;
    });
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> newPosts = jsonDecode(response.body)['posts'];
        setState(() {
          posts = newPosts;
          isLoadingPosts = false;
        });
      } else {
        _showErrorSnackbar('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching posts: $e');
    } finally {
      setState(() {
        isLoadingPosts = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showLogoutConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> appBarTitles = [
      'Products List',
      'Recipe List',
      'Users List',
      'Posts List'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[_selectedIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _showLogoutConfirmationDialog,
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Tab 0 - Products
          isLoadingProducts
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ListTile(
                            leading: Image.network(product['thumbnail']),
                            title: Text(product['title']),
                            subtitle: Text('\$${product['price']}'),
                            onTap: () {
                              // Navigate to ProductDetailPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed:
                              currentProductPage > 1 ? _previousProductPage : null,
                          child: Text('Previous'),
                        ),
                        Text('Page $currentProductPage'),
                        ElevatedButton(
                          onPressed: _nextProductPage,
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ],
                ),
          // Tab 1 - Recipes
          isLoadingRecipes
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: ListTile(
                              title: Text(recipe['name']),
                              leading: Image.network(recipe['image']),
                              onTap: () {
                                // Navigate to RecipeDetailPage with the selected recipe
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetailPage(recipe: recipe),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed:
                              currentRecipePage > 1 ? _previousRecipePage : null,
                          child: Text('Previous'),
                        ),
                        Text('Page $currentRecipePage'),
                        ElevatedButton(
                          onPressed: _nextRecipePage,
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ],
                ),
          // Tab 2 - Users
          isLoadingUsers
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user['image']),
                        ),
                        title: Text('${user['firstName']} ${user['lastName']}'),
                        subtitle: Text(user['email']),
                        onTap: () {
                          // Navigate to UserDetailPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailPage(user: user),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
          // Tab 3 - Posts
          isLoadingPosts
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(post['title']),
                        onTap: () {
                          // Navigate to PostDetailPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailPage(post: post),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Posts',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }

  void _nextProductPage() {
    setState(() {
      currentProductPage++;
    });
    fetchProducts(page: currentProductPage);
  }

  void _previousProductPage() {
    if (currentProductPage > 1) {
      setState(() {
        currentProductPage--;
      });
      fetchProducts(page: currentProductPage);
    }
  }

  void _nextRecipePage() {
    setState(() {
      currentRecipePage++;
    });
    fetchRecipes(page: currentRecipePage);
  }

  void _previousRecipePage() {
    if (currentRecipePage > 1) {
      setState(() {
        currentRecipePage--;
      });
      fetchRecipes(page: currentRecipePage);
    }
  }
}
