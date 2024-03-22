import 'package:localstore/localstore.dart';
import '../models/article.dart';

class LocalStorageService {
  final store = Localstore.instance;

  Future<void> saveArticlesToLocal(List<Article> articles) async {
    await store.collection('articles').doc('data').set({'articles': articles});
  }

  Future<List<Article>> getArticlesFromLocal() async {
    final data = await store.collection('articles').doc('data').get();
    if (data != null && data['articles'] != null) {
      List<dynamic> articlesData = data['articles'];
      List<Article> articles =
          articlesData.map((data) => Article.fromJson(data)).toList();
      return articles;
    } else {
      return [];
    }
  }
}
