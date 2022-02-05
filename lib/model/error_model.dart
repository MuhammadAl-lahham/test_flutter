import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable{
  final ErrorType errorType;
  final String errorValue;

  const ErrorModel({required this.errorType,required this.errorValue});

  @override
  List<Object?> get props => [errorType, errorValue];
}

enum ErrorType{other, noItemsError}