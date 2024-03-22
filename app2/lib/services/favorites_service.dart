import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/article.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  Future<void> saveFavoriteArticles(List<Article> articles) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articlesJson =
        articles.map((article) => jsonEncode(article.toJson())).toList();
    await prefs.setStringList(_favoritesKey, articlesJson);
  }

  Future<List<Article>> loadFavoriteArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articlesJson = prefs.getStringList(_favoritesKey);
    if (articlesJson != null) {
      return articlesJson
          .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
          .toList();
    }
    return [];
  }

  Future<void> addFavoriteArticle(Article article) async {
    List<Article> currentFavorites = await loadFavoriteArticles();
    currentFavorites.add(article);
    await saveFavoriteArticles(currentFavorites);
  }

  Future<void> removeFavoriteArticle(String url) async {
    List<Article> currentFavorites = await loadFavoriteArticles();
    currentFavorites.removeWhere((article) => article.url == url);
    await saveFavoriteArticles(currentFavorites);
  }
}