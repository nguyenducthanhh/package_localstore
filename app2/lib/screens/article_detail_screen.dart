import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/favorites_service.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  ArticleDetailScreen({required this.article});

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    List<Article> favoriteArticles =
        await _favoritesService.loadFavoriteArticles();
    setState(() {
      _isFavorited = favoriteArticles.any((a) => a.url == widget.article.url);
    });
  }

  void _toggleFavorite() async {
    if (_isFavorited) {
      await _favoritesService.removeFavoriteArticle(widget.article.url);
    } else {
      await _favoritesService.addFavoriteArticle(widget.article);
    }
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
        actions: <Widget>[
          IconButton(
            icon: _isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: _isFavorited ? Colors.red : null,
            onPressed: _toggleFavorite,
            tooltip:
                _isFavorited ? 'Remove from favorites' : 'Add to favorites',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            widget.article.urlToImage.isNotEmpty
                ? Image.network(widget.article.urlToImage)
                : SizedBox(
                    height: 200,
                    child: Center(child: Text('No image available'))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.description,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 8.0),
                  Text(widget.article.content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}