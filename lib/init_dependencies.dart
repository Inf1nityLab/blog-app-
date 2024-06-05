import 'package:blog_app_clean_architecture/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app_clean_architecture/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/repository/auth_repository.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/usecases/current_user.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/usecases/user_login.dart';
import 'package:blog_app_clean_architecture/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_clean_architecture/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app_clean_architecture/feature/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app_clean_architecture/feature/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app_clean_architecture/feature/blog/domain/usecase/upload_blog.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'feature/auth/data/data_sources/auth_remote_data_sources.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  initAuth();
  initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.api,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
  // Repository
    ..registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
  // Usecases
    ..registerFactory(
          () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
          () => UserLogin(authRepository: serviceLocator()

      ),
    )
    ..registerFactory(
          () => CurrentUser(
         authRepository: serviceLocator(),
      ),
    )
  // Bloc
    ..registerLazySingleton(
          () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
      ),
    );
}
