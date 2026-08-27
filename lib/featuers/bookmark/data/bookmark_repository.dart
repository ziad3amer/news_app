import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:news_app/core/constans/constans.dart';
import 'package:news_app/featuers/bookmark/model/bookmark_model.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

class BookmarkRepository {
  //this is singleton class
  BookmarkRepository._internal();
  static final BookmarkRepository _instance = BookmarkRepository._internal();
  factory BookmarkRepository() => _instance;



  Box<BookmarkModel>? _bookmarkBox;

  Box<BookmarkModel> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception('bookmarkBox is not initialized');
    }
    return _bookmarkBox!;
  }
//دي Method مسؤولة عن فتح الـ Hive Box./
  Future<void> init() async {
    _bookmarkBox = await Hive.openBox<BookmarkModel>(Constants.bookmarkBox);
  }

  ///Add a news artical to bookmark
  ///use artical url as key
  Future<void> addBookmark(NewsArticlesModel article) async {
    ///هنا بنحول الـ Article إلى Bookmark
    /// NewsArticlesModel
    ///        ↓
    /// BookmarkModel
    final bookmark = BookmarkModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url ?? "",
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      bookmarkedAt: DateTime.now(),
    );

    await bookmarkBox.put(article.url, bookmark);
  }

  ///remove a  bookmark by artical url
  Future<void> removeBookmark(String articleUrl) async {
    await bookmarkBox.delete(articleUrl);
  }

  ///GET All BookMark ,
  List<BookmarkModel> getBookMark() => bookmarkBox.values.toList();

  ///Check if in atricle is bookmarked
  bool isBookMarked(String? articleUrl) {
    if (articleUrl == null || articleUrl.isEmpty) return false;
    return bookmarkBox.containsKey(articleUrl);

    ///containsKey=>يعني موجوده قبل كدا ولا لا
  }

  ///Get Single BookMark by url
  BookmarkModel? getBookMarkByUrl(String? articleUrl) {
    return bookmarkBox.get(articleUrl);
  }

  ///Toggle BookMark
  ///3ayez sharh tany le el function de
  /// لو الحاجة ON خليها OFF، ولو OFF خليها ON.
  Future<bool> toggleBookMark(NewsArticlesModel article) async {
    if (isBookMarked(article.url)) {
      await removeBookmark(article.url!);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }

  ///get total bookmark count
  ///ي بتجيب عدد الـ Bookmarks.
  int bookMarkCount() {
    return bookmarkBox.length;
  }

  ///clear all bookmark
  Future<void> clearAllBookmarks() async {
    await bookmarkBox.clear();
  }

  ///search bookmark by title or description
  List<BookmarkModel> searchBookmark(String query) {
    if (query.isEmpty) return getBookMark();
    final lowerCaseQuery = query.toLowerCase();

    ///   دي معناها:
    // لف على كل الـ Bookmarks واختار اللي يحقق شرط معين
    return bookmarkBox.values.where((bookmark) {
      final titleMatch = bookmark.title?.toLowerCase().contains(lowerCaseQuery)??false;
      final descriptionMatch =
          bookmark.description?.toLowerCase().contains(lowerCaseQuery) ?? false;
      final authorMatch =
          bookmark.author?.toLowerCase().contains(lowerCaseQuery) ?? false;

      return titleMatch || descriptionMatch || authorMatch;
    }).toList()..sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));
  }

  NewsArticlesModel bookmarkToArticle(BookmarkModel bookmark) {
    return NewsArticlesModel(
      author: bookmark.author,
      title: bookmark.title??'',
      description: bookmark.description,
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.content,
    );
  }
}
