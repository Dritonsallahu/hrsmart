// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => ['Keni problem me rrjet!'];
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => ['Kerkesa juaj deshtoi!\nJu lutem provoni perseri.'];
}

class DuplicateDataFailure extends Failure {
  String? message;
  DuplicateDataFailure({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message ?? 'Keto te dhena tashme ekzistojne!'];
  getMessage(){
    return "Ju keni hapur diten!";
  }
}

class UnauthorizedFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => ['Qasja juaj ka skaduar, ju lutem kyquni perseri per te vazhduar.'];
}

class EmptyDataFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => ['Nuk ka asnje te dhene!'];
}

class UnfilledDataFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => ['Ju lutem plotesoni te gjitha fushat e kerkuara'];
}

class WrongFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => ['Ka ndodhur nje problem!\n Ju lutem provoni perseri.'];
}

class NothingFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [ ];
}
