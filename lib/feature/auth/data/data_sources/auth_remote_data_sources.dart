import 'package:blog_app_clean_architecture/core/error/exceprions.dart';
import 'package:blog_app_clean_architecture/feature/auth/data/models/user_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModels> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});

  Future<UserModels> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<UserModels?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  // TODO: implement currentUserSession
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModels> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response =
          await supabaseClient.auth.signInWithPassword(password: password, email: email);
      if (response.user == null){
        throw const ServerException('User is null');
      }
    } catch (e) {
      ServerException(e.toString());
    }


    throw UnimplementedError();
  }

  @override
  Future<UserModels> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});

      if (response.user == null) {
        throw const ServerException('User is null');
      }
      return UserModels.fromJson(response.user!.toJson());
      // if(response.user == null){
      //   throw const ServerException('User is null');
      // }
      // return response.user!.id;
    } catch (e) {
      ServerException(e.toString());
    }
    throw UnimplementedError();
  }

  @override
  Future<UserModels?> getCurrentUserData() async{
    try{
      if(currentUserSession != null){
        final userData = await supabaseClient.from('profiles').select().eq('id', currentUserSession!.user.id);
        return UserModels.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e){
      throw ServerException(e.toString());
    }

  }
  
  
  // @override
  // Future<UserModels?> getCurrentUserData() async{
  //   try{
  //    if (currentUserSession != null){
  //      final userData = await supabaseClient.from('prfiles').select().eq('id', currentUserSession!.user.id);
  //      return UserModels.fromJson(userData.first).copyWith(
  //        email: currentUserSession!.user.email,
  //      );
  //    }
  //    return null;
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  //   throw UnimplementedError();
  // }


}


