import 'dart:io';

import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/core/usecase/usecase.dart';
import 'package:blog_app_clean_architecture/feature/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/src/either.dart';

import '../entities/blog.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.paoterId,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final File image;
  final String paoterId;
  final String title;
  final String content;
  final List<String> topics;

  UploadBlogParams(
      {required this.image,
      required this.paoterId,
      required this.title,
      required this.content,
      required this.topics});
}

// class UploadBlog implements UseCase<Blog, UploadBlogParams> {
//   final BlogRepository blogRepository;
//
//   UploadBlog(this.blogRepository);
//
//   @override
//   Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
//     return await blogRepository.uploadBlog(image: params.image,
//         title: params.title,
//         content: params.content,
//         posterId: params.posterId,
//         topics: params.topics);
//
//   }
// }
//
// class UploadBlogParams {
//   final String posterId;
//   final String title;
//   final String content;
//   final File image;
//   final List<String> topics;
//
//   UploadBlogParams({required this.posterId,
//     required this.title,
//     required this.content,
//     required this.image,
//     required this.topics});
// }
