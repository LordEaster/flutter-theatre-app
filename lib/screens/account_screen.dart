import 'package:flutter/material.dart';
import '../utils/json_loader.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  Future<List<dynamic>> _loadHistory() async {
    return await loadJsonData('assets/json/watch_history.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://raw.githubusercontent.com/LordEaster/ICON-LOGO/refs/heads/main/snowcone2.PNG'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Snowcone Bunny',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'snowcone@bsospace.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              _buildSectionTitle('History'),
              SizedBox(height: 8),
              FutureBuilder<List<dynamic>>(
                future: _loadHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading history'));
                  } else {
                    final history = snapshot.data ?? [];
                    final recentHistory = history.reversed.take(3).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: recentHistory.length,
                          itemBuilder: (context, index) {
                            final item = recentHistory[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  title: Text(
                                    item['title'],
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Watched on: ${item['date']}',
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullHistoryScreen(history: history),
                                ),
                              );
                            },
                            child: Text('View More'),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 32),
              _buildSectionTitle('Contact Us'),
              SizedBox(height: 8),
              _buildContactForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Your Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Your Message',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Thank You!'),
                content: Text('Your message has been sent.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}

class FullHistoryScreen extends StatelessWidget {
  final List<dynamic> history;

  const FullHistoryScreen({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Watch History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Text(
                  item['title'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Watched on: ${item['date']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
