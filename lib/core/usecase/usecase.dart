import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';


abstract interface class UseCase<SuccessType, Params>{
  Future<Either<Failure, SuccessType>> call(Params params);
}

//
// abstract interface class UseCase<SuccessType,Params>{
//   Future<Either<Failure, SuccessType>> call(Params params);
// }