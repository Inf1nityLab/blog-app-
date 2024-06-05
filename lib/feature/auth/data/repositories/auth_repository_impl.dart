import 'package:blog_app_clean_architecture/core/error/exceprions.dart';
import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/feature/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../../core/common/entities/user.dart';



class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUserData() async{
    try{
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null){
        return left(Failure('User not logged in!'));
      }
    } on ServerException catch (e){
      return left(Failure(e.message));
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() async =>
    await remoteDataSource.loginWithEmailAndPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
        required String email,
        required String password}) async {
    return _getUser(() async =>
    await remoteDataSource.signUpWithEmailAndPassword(
        name: name, email: email, password: password));
  }


  Future<Either<Failure, User>> _getUser(Future<User> Function() fn,) async {
    try {
      final userId = await fn();
      return right(userId);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }



}

