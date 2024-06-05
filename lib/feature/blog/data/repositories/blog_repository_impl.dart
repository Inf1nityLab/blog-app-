import 'dart:io';

import 'package:blog_app_clean_architecture/core/error/exceprions.dart';
import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app_clean_architecture/feature/blog/data/model/blog_model.dart';
import 'package:blog_app_clean_architecture/feature/blog/domain/entities/blog.dart';
import 'package:blog_app_clean_architecture/feature/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updateAt: DateTime.now());

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blog: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = blogRemoteDataSource.uploadBlog(blogModel);
      right(uploadedBlog);
    } on ServerException catch (e) {
      left(
        Failure(
          e.toString(),
        ),
      );
    }
    throw UnimplementedError();
  }
}


