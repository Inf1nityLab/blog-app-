import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/usecase/upload_blog.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;

  BlogBloc({required UploadBlog uploadBlog})
      : _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUpload>(_blogUpload);
  }

  void _blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        image: event.image,
        paoterId: event.posterId,
        title: event.title,
        content: event.content,
        topics: event.topics));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogSuccess(),
      ),
    );
  }

// void _blogUpload(BlogUpload event, Emitter<BlogState> emit) async{
//   final res = await _uploadBlog(
//     UploadBlogParams(
//       posterId: event.posterId,
//       title: event.title,
//       content: event.content,
//       image: event.image,
//       topics: event.topics,
//     ),
//   );
//
//   res.fold(
//         (l) => emit(BlogFailure(l.message)),
//         (r) => emit(BlogSuccess()),
//   );
// }
}
