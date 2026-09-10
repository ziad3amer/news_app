part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  @override
  List<Object?> get props => [
    everythingStatus,
    newsTopHeadlineStates,
    errorMessage,
    selectedCategory,
    newsTopHeadlineList,
    newsEverythingList,
  ];

  HomeState({
    this.everythingStatus = RequestStatusEnums.loading,
    this.newsTopHeadlineStates = RequestStatusEnums.loading,
    this.errorMessage,
    this.selectedCategory,
    this.newsTopHeadlineList = const [],
    this.newsEverythingList = const [],
  });

  final RequestStatusEnums everythingStatus;

  final RequestStatusEnums newsTopHeadlineStates;

  final String? errorMessage;
  final String? selectedCategory;
  final List<NewsArticlesModel> newsTopHeadlineList;

  final List<NewsArticlesModel> newsEverythingList;

  HomeState copyWith({
    RequestStatusEnums? everythingStatus,
    RequestStatusEnums? newsTopHeadlineStates,
    String? errorMessage,
    String? selectedCategory,
    List<NewsArticlesModel>? newsTopHeadlineList,
    List<NewsArticlesModel>? newsEverythingList,
  }) {
    return HomeState(
      everythingStatus: everythingStatus ?? this.everythingStatus,
      newsTopHeadlineStates: newsTopHeadlineStates ?? this.newsTopHeadlineStates,
      errorMessage: errorMessage ,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      newsTopHeadlineList: newsTopHeadlineList ?? this.newsTopHeadlineList,
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
    );
  }
}

final class HomeInitial extends HomeState {}
