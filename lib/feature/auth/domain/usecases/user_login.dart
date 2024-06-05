import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/core/usecase/usecase.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  const UserLogin({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
    throw UnimplementedError();
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
// class UserLogin implements UseCase<User, UserLoginParams> {
//   final AuthRepository authRepository;
//
//   const UserLogin({required this.authRepository});
//
//   @override
//   Future<Either<Failure, User>> call(UserLoginParams params) async {
//     return await authRepository.loginWithEmailAndPassword(
//         email: params.email, password: params.password);
//     // TODO: implement call
//     throw UnimplementedError();
//   }
// }
//
// class UserLoginParams {
//   final String email;
//   final String password;
//
//   UserLoginParams({required this.email, required this.password});
// }
