import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_detail_screen.dart';
import '../services/api_service.dart';
import "../widget/search_widget.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> _categories = [
    'All',
    'Business',
    'Technology',
    'Health',
    'Sports'
  ];
  late Future<List<Article>> futureArticles;
  final ApiService apiService =
      ApiService(apiKey: '74ba9bb09016446e9cd45de54a6e3513');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          futureArticles = apiService.fetchAllCategories();
        });
      } else {
        setState(() {
          futureArticles = apiService
              .fetchTopHeadlinesByCategory(_categories[_tabController.index]);
        });
      }
    });
    futureArticles = apiService.fetchTopHeadlinesByCategory(_categories.first);
  }

  Future<void> _refreshArticles() async {
    setState(() {
      if (_tabController.index == 0) {
        futureArticles = apiService.fetchAllCategories();
      } else {
        futureArticles = apiService
            .fetchTopHeadlinesByCategory(_categories[_tabController.index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore More Now'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _categories.map((category) => Tab(text: category)).toList(),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(apiService: apiService),
                );
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshArticles,
        child: TabBarView(
          controller: _tabController,
          children: _categories.map((category) {
            return FutureBuilder<List<Article>>(
              future: _tabController.index == 0
                  ? apiService.fetchAllCategories()
                  : apiService.fetchTopHeadlinesByCategory(category),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailScreen(article: article)),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No articles found'));
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
