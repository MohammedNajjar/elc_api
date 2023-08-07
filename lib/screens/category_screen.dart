import 'package:elc_api/api/controllers/auth_api_controller.dart';
import 'package:elc_api/api/controllers/user_api_contrroller.dart';
import 'package:elc_api/models/category.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> _future;
  List<Category> _categories = <Category>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UserApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
              onPressed: () async => await logout(context),
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<List<Category>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _categories = snapshot.data ?? [];
              return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: _categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(_categories[index].image),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(_categories[index].title)
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Column(
                  children: const [
                    Icon(
                      Icons.warning,
                      size: 80,
                    ),
                    Text(
                      'No Data',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 24),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
  Future<void> logout (BuildContext context) async {
    bool loggedOut = await AuthApiController(). logout() ;
    if (loggedOut) Navigator. pushReplacementNamed(context, '/login_screen');}
}
