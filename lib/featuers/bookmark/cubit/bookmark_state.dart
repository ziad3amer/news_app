part of 'bookmark_cubit.dart';

@immutable
class BookmarkState extends Equatable {
  const BookmarkState({
    this.bookmarkStatus = RequestStatusEnums.loading,
    this.bookmarks = const [],
    this.errorMessage,
    this.searchQuery = "",
    this.isSearching = false,
  });

  final RequestStatusEnums bookmarkStatus;

  final List<BookmarkModel> bookmarks;

  final String? errorMessage;

  final String searchQuery;

  final bool isSearching;

  BookmarkState copyWith({
    RequestStatusEnums? bookmarkStatus,
    List<BookmarkModel>? bookmarks,
    String? errorMessage,
    String? searchQuery,
    bool? isSearching,
  }) {
    return BookmarkState(
      bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
    bookmarkStatus,
    bookmarks,
    errorMessage,
    searchQuery,
    isSearching,
  ];
}