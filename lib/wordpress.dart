// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' show parse;
import 'package:html_unescape/html_unescape.dart';

class WordpressScreen extends StatefulWidget {
  @override
  _WordpressScreenState createState() => _WordpressScreenState();
}

class _WordpressScreenState extends State<WordpressScreen> {
  List _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://tri.be/wp-json/wp/v2/posts?_embed'));

    if (response.statusCode == 200) {
      setState(() {
        _posts = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/logo.png'),
                  radius: 70,
                ),
                SizedBox(height: 20),
                Text(
                  'Modern Tribe',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                _posts.isEmpty
                    ? CircularProgressIndicator()
                    : Column(
                        children: _posts
                            .take(3)
                            .map((post) => NewsCard(post: post))
                            .toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Map post;

  const NewsCard({required this.post});

  @override
  Widget build(BuildContext context) {
    HtmlUnescape unescape = HtmlUnescape();
    String title = unescape.convert(post['title']['rendered']);
    String excerpt = unescape.convert(post['excerpt']['rendered']
        .replaceAll(RegExp(r'<[^>]*>'), '')); // Remove HTML tags
    Uri url = Uri.parse(post['link']);
    String imageUrl = post['_embedded']['wp:featuredmedia'][0]['source_url'];

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                : SizedBox.shrink(), // Show image if available
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              excerpt,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                'Leer más',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
