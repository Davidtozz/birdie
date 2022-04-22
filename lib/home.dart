import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(elevation: 5.0),
      appBar: AppBar(
        // elevation: 2.5,
        actions: [
          IconButton(
              onPressed: () {
                print('pressed settings');
              },
              icon: Icon(Icons.settings)),
        ],
        backgroundColor: const Color.fromARGB(171, 3, 117, 218),
        title: const Text("Home page title"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/birdie.png'),
            ),
            title: const Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
            subtitle: const Text('last online: 10:00'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.person_add_outlined), label: "Add new user"),
          NavigationDestination(
              icon: Icon(Icons.group_add_outlined), label: "View users"),
        ],
      ),
    );
  }
}
