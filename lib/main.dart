import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: GalleryPage(),
    );
  }
}

class GalleryPage extends StatelessWidget {
  GalleryPage({super.key});

  final List<Map<String, String>> images = [
    {
      'url':
          'https://static1.dualshockersimages.com/wordpress/wp-content/uploads/2023/09/10-most-expensive-anime-series-ranked.jpg',
      'title': 'Most Expensive Anime Series'
    },
    {
      'url':
          'https://uchi.imgix.net/properties/anime2.png?crop=focalpoint&domain=uchi.imgix.net&fit=crop&fm=webp&fp-x=0.5&fp-y=0.5&h=558&ixlib=php-3.3.1&q=82&usm=20&w=992',
      'title': 'Anime 2'
    },
    {
      'url':
          'https://t4.ftcdn.net/jpg/05/62/02/41/360_F_562024161_tGM4lFlnO0OczLYHFFuNNdMUTG9ekHxb.jpg',
      'title': 'Anime Image 3'
    },
    {
      'url':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc-mqLayESeL4RE5ayMWt_nFEC3v3b4SvwuQ&s',
      'title': 'Anime Image 4'
    },
    {
      'url':
          'https://static1.cbrimages.com/wordpress/wp-content/uploads/2024/04/split-images-of-jojo-s-bizzare-adventure-demon-slayer-and-naruto.jpg',
      'title': 'JoJo & Demon Slayer'
    },
    {
      'url':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSIjwCE5LbKVq7F-y_boRM_uTWOJs-3vZ01g&s',
      'title': 'Anime Image 6'
    },
  ];

  @override
  Widget build(BuildContext context) {
    int columns = (MediaQuery.of(context).size.width / 200).floor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullscreenImagePage(imageUrl: images[index]['url']!),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        images[index]['url']!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Center(
                              child: Text('Failed to load image',
                                  style: TextStyle(color: Colors.red)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        images[index]['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullscreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullscreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
