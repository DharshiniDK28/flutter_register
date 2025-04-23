import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class DrawerClicked extends HomeEvent {
  const DrawerClicked();
}

class CountryChanged extends HomeEvent {
  final String country;

  const CountryChanged({required this.country});

  @override
  List<Object?> get props => [country];
}

class CallNowClicked extends HomeEvent {
  const CallNowClicked();
}

class SendSmsClicked extends HomeEvent {
  const SendSmsClicked();
}

class PageTapped extends HomeEvent {
  final int index;

  const PageTapped({required this.index});

  @override
  List<Object?> get props => [index];
}