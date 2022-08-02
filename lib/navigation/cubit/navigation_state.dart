part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final List<MaterialPage> pages = [LoginPage.page(), SignUpPage.page()];

  @override
  List<Object?> get props => [pages];
}

class NavigationInitial extends NavigationState {}
