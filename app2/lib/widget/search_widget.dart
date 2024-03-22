import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import '../screens/article_detail_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  final ApiService apiService;

  CustomSearchDelegate({required this.apiService});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder<List<Article>>(
        future: apiService.searchArticles(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Article article = snapshot.data![index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  leading: article.urlToImage.isNotEmpty
                      ? Image.network(article.urlToImage)
                      : null,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailScreen(article: article),
                    ));
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No results found'));
          }
        },
      );
    } else {
      return Center(child: Text('Enter a search term to start'));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search News Articles'),
    );
  }
}