import 'package:flutter/material.dart';
import '../utils/json_loader.dart';

class CinemaScreen extends StatelessWidget {
  const CinemaScreen({Key? key}) : super(key: key);

  Future<List<dynamic>> loadCinemas() async {
    return await loadJsonData('assets/json/cinemas.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cinemas')),
      body: FutureBuilder<List<dynamic>>(
        future: loadCinemas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading cinemas'));
          } else {
            final cinemas = snapshot.data ?? [];
            return ListView.builder(
              itemCount: cinemas.length,
              itemBuilder: (context, index) {
                final cinema = cinemas[index];
                return ListTile(
                  title: Text(cinema['name']),
                  subtitle: Text(cinema['address']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CinemaDetailsScreen(cinema: cinema),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CinemaDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> cinema;

  const CinemaDetailsScreen({Key? key, required this.cinema}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cinema['name'])),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cinema['name'], style: TextStyle(fontSize: 24)),
            Text(cinema['address'], style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Text(cinema['description']),
          ],
        ),
      ),
    );
  }
}
