part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final List<MaterialPage> pages = [
    SignUpPage.page(),
    SignInPage.page(),
  ];

  @override
  List<Object?> get props => [pages];
}

class NavigationInitial extends NavigationState {}
