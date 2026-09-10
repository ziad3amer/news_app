part of 'search_cubit.dart';

@immutable
 class SearchState extends Equatable {
  final List<NewsArticlesModel> newsEverythingList;
  final RequestStatusEnums everythingStatus ;
  final String? errorMessage;


  SearchState({
    this.everythingStatus = RequestStatusEnums.loading,
    this.newsEverythingList = const [],
    this.errorMessage,
  });
  SearchState copyWith({
    List<NewsArticlesModel>? newsEverythingList,
   RequestStatusEnums? everythingStatus ,
   String? errorMessage,
}){
    return SearchState(
      everythingStatus: everythingStatus ?? this.everythingStatus,
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


  @override
  List<Object?> get props => [
    everythingStatus,
    newsEverythingList,
    errorMessage,

  ];


}


