import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vemchat',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _themeMode,
      home: HomeScreen(toggleTheme: toggleTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vemchat Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            tooltip: 'Téma váltása',
            onPressed: toggleTheme,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 20),
            FeedPost(
              username: 'vem_user',
              imageUrl: 'https://via.placeholder.com/300',
              caption: 'Ez az első Vemchat poszt! 🎉',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage('https://via.placeholder.com/100'),
        ),
        SizedBox(width: 12),
        Text(
          'vem_user',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class FeedPost extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String caption;

  const FeedPost({
    Key? key,
    required this.username,
    required this.imageUrl,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(caption),
          ),
        ],
      ),
    );
  }
}
