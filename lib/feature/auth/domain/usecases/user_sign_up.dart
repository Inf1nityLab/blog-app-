import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/core/usecase/usecase.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';



class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
    // TODO: implement call
    throw UnimplementedError();
  }
}


class UserSignUpParams {
  final String name;
  final String email;
  final String password ;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}

// class UserSignUp implements UseCase<String, UserSignUpParams> {
//   final AuthRepository authRepository;
//
//   const UserSignUp(this.authRepository);
//
//   @override
//   Future<Either<Failure, String>> call(UserSignUpParams params) async{
//     return await authRepository.signUpWithEmailAndPassword(
//         name: params.name, email: params.email, password: params.email);
//
//   }
// }
//
// class UserSignUpParams {
//   final String email;
//   final String password;
//   final String name;
//
//   UserSignUpParams(
//       {required this.email, required this.password, required this.name});
// }
