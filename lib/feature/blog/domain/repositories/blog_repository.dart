import 'dart:io';

import 'package:blog_app_clean_architecture/core/error/failure.dart';
import 'package:blog_app_clean_architecture/feature/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}


