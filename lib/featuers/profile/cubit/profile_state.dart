part of 'profile_cubit.dart';

@immutable
 class ProfileState extends Equatable{
  ProfileState ({
    this.selectedImage,
    this.userName,
    this.countryName,
    this.countryCode,
  }
      );

  final XFile? selectedImage;
 final String? userName;
 final String? countryName;
 final String? countryCode;

  ProfileState copyWith({
    XFile? selectedImage,
    String? userName,
    String? countryName,
    String? countryCode,
  }) {
    return ProfileState(
      selectedImage: selectedImage ?? this.selectedImage,
      userName: userName ?? this.userName,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    selectedImage,
    userName,
    countryName,
    countryCode,
  ];





}


