import 'package:flutter/material.dart';
import 'movie_description_screen.dart';
import '../utils/json_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<dynamic>> _loadMovies() async {
    return await loadJsonData('assets/json/movies.json');
  }

  DateTime _parseDate(String date) {
    final parts = date.split('/');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  List<dynamic> _filterHotMovies(List<dynamic> movies) {
    return movies.sublist(movies.length - 3);
  }

  List<dynamic> _filterNowShowing(List<dynamic> movies) {
    final now = DateTime.now();
    final cutoffDate = now.subtract(Duration(days: 60));
    return movies.where((movie) {
      final releaseDate = _parseDate(movie['date']);
      return releaseDate.isAfter(cutoffDate) && releaseDate.isBefore(now);
    }).toList();
  }

  List<dynamic> _filterComingSoon(List<dynamic> movies) {
    final now = DateTime.now();
    return movies.where((movie) {
      final releaseDate = _parseDate(movie['date']);
      return releaseDate.isAfter(now) || releaseDate.isAtSameMomentAs(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder<List<dynamic>>(
        future: _loadMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading movies.'));
          } else {
            final movies = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Section(title: 'Hot Movies', movies: _filterHotMovies(movies)),
                  _Section(title: 'Now Showing', movies: _filterNowShowing(movies)),
                  _Section(title: 'Coming Soon', movies: _filterComingSoon(movies)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<dynamic> movies;

  const _Section({Key? key, required this.title, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _MovieTile(movie: movie);
            },
          ),
        ),
      ],
    );
  }
}

class _MovieTile extends StatelessWidget {
  final Map<String, dynamic> movie;

  const _MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDescriptionScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  movie['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              movie['title'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}