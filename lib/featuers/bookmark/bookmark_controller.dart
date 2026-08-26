import 'package:flutter/foundation.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/featuers/bookmark/data/bookmark_repository.dart';
import 'package:news_app/featuers/bookmark/model/bookmark_model.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

class BookmarkController extends ChangeNotifier with SafeNotify {
  final BookmarkRepository _repository = BookmarkRepository();

  ///state variable
  RequestStatusEnums bookmarkStatus = RequestStatusEnums.loading;
  List<BookmarkModel> bookmarks = [];
  String? errorMessage;

  ///Search State
  String searchQuery = "";
  bool isSearching = false;

  ///Constructor
  BookmarkController() {
    loadBookmarks();
  }

  void loadBookmarks() {
    try {
      bookmarkStatus = RequestStatusEnums.loading;
      safeNotify();

      if (searchQuery.isEmpty) {
        bookmarks = _repository.getBookMark();
      } else {
        bookmarks = _repository.searchBookmark(searchQuery);
      }
      bookmarkStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      bookmarkStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  Future<bool> toggleBookmark(NewsArticlesModel article) async {
    try {
      final wasAdded = _repository.toggleBookMark(article);
      loadBookmarks();
      return wasAdded;
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
      return false;
    }
  }

  Future<void> addBookmark(NewsArticlesModel article) async {
    try {
      await _repository.addBookmark(article);
      loadBookmarks();
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
    }
  }

  Future<void> removeBookmark(String articleUrl) async {
    try {
      await _repository.removeBookmark(articleUrl);
      loadBookmarks();
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
    }
  }

  bool isArticleBookmarked(String? articleUrl) {
    return _repository.isBookMarked(articleUrl);
  }

  int get bookmarkCount => _repository.bookMarkCount();

  Future<void> clearAllBookmarks() async {
    try {
      await _repository.clearAllBookmarks();
      loadBookmarks();
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
    }
  }

  void searchBookmarks(String query) {
    searchQuery = query;
    isSearching = query.isNotEmpty;
    loadBookmarks();
  }

  void clearSearch() {
    searchQuery = "";
    isSearching = false;
    loadBookmarks();
  }

  NewsArticlesModel getArticleFromBookmark(BookmarkModel bookmark) {
    return _repository.bookmarkToArticle(bookmark);
  }



 Future<void> refresh() async {
    loadBookmarks();
 }




 List<NewsArticlesModel>get bookmarksArticles{
    return bookmarks.map((bookmark) => _repository.bookmarkToArticle(bookmark)).toList();
 }









}
