import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuis Mola',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final List<Map<String, String>?> apps=[
    {'image':'assets/images/gallery.jpg','label':'Gallery'},
    {'image':'assets/images/camera.jpg','label':'Camera'},
    {'image':'assets/images/notes.jpg','label':'Notes'},
    {'image':'assets/images/livin by mandiri.jpg','label':'Livin by Mandiri'},
    {'image':'assets/images/google.jpg','label':'Google'},
    {'image':'assets/images/sosmedâ.jpg','label':'Sosmedâ'},
    {'image':'assets/images/calculator.jpg','label':'Calculator'},
    null,
    {'image':'assets/images/gaming hub.jpg','label':'Gaming Hub'}
  ];

  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/wallpaper.jpg',
          fit: BoxFit.cover,
        ),

        SafeArea(
          child: Column(
            children: [

              // SearchBar
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30.0),
                child: _buildSearchBar(),
              ),
            
              //Grid ikon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: apps.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 24.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final app = apps[index];
                    if (app == null) {
                      return const SizedBox.shrink();
                    }
                    return _buildIcon(app['image']!, app['label']!);
                  },
                  ),
              ),
            ]
          ),
        ),
      ],
    ),
  );
}

Widget _buildSearchBar(){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Row(
      children: [
        Image.asset('assets/images/icongoogle.jpg', width: 30.0, height: 30.0),
        const SizedBox(width: 15),
        const Expanded(
          child: Text(
            '',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const Icon(Icons.mic, color: Colors.white70, size: 24),
        const SizedBox(width: 15),
        const Icon(Icons.camera_alt_outlined, color: Colors.white70, size: 24),
        const SizedBox(width: 5),
      ],
    ),
  );
}

  Widget _buildIcon(String imagePath, String label) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          imagePath,
          width: 60.0,
          height: 60.0,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          ),
      
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    );
  }
}