part of 'onpording_cubit.dart';

@immutable
 class OnbordindState extends Equatable {

  OnbordindState({
    this.currentIndex=0,
    this.isLastPage=false,
  });
  final int currentIndex ;
 final bool isLastPage ;

  @override
  List<Object?> get props => [currentIndex, isLastPage];

  OnbordindState copyWith({
    int? currentIndex,
    bool? isLastPage,
}){
    return OnbordindState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }


}

