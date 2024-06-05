import 'dart:io';
import 'package:blog_app_clean_architecture/core/common/widgets/loader.dart';
import 'package:blog_app_clean_architecture/core/theme/app_palete.dart';
import 'package:blog_app_clean_architecture/core/utils/pick_image.dart';
import 'package:blog_app_clean_architecture/core/utils/show_snackbar.dart';

import 'package:blog_app_clean_architecture/feature/blog/presentation/pages/blog_page.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/widgets/edit_blog_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubit/app_user_cubit.dart';
import '../bloc/blog_bloc.dart';

class AddBlogPag extends StatefulWidget {
  const AddBlogPag({super.key});

  @override
  State<AddBlogPag> createState() => _AddBlogPagState();
}

class _AddBlogPagState extends State<AddBlogPag> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedOption = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickeImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedOption.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
                posterId: posterId,
                title: titleController.text.trim(),
                content: contentController.text.trim(),
                image: image!,
                topics: selectedOption),
          );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading){
            return const LoaderWidget();
          }
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              color: AppPallete.borderColor,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Select image')
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Technology',
                          'Business',
                          'Programming',
                          'Entertaiment'
                        ]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (selectedOption.contains(e)) {
                                          selectedOption.remove(e);
                                        } else {
                                          selectedOption.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(e),
                                        color: WidgetStatePropertyAll(
                                            selectedOption.contains(e)
                                                ? AppPallete.gradient1
                                                : null),
                                        side: selectedOption.contains(e)
                                            ? null
                                            : const BorderSide(
                                                color: AppPallete.borderColor),
                                      )),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    EditBlogWidget(
                        text: 'Blog title', controller: titleController),
                    const SizedBox(
                      height: 10,
                    ),
                    EditBlogWidget(
                        text: 'Blog content', controller: contentController)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'dart:io';
//
// import 'package:blog_app_clean_architecture/core/theme/app_palete.dart';
// import 'package:blog_app_clean_architecture/core/utils/pick_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
//
// class AddBlogPage extends StatefulWidget {
//   const AddBlogPage({super.key});
//
//   @override
//   State<AddBlogPage> createState() => _AddBlogPageState();
// }
//
// class _AddBlogPageState extends State<AddBlogPage> {
//
//   List<String> selectedTopics = [];
//   File? image;
//   void selectImage() async{
//     final pickedImage = await pickImage();
//     if(pickedImage != null){
//       setState(() {
//         image = pickedImage;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: const [Icon(Icons.done_rounded)],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             image != null? Image.file(image!) : GestureDetector(
//               onTap: (){
//                 selectImage();
//               },
//               child: DottedBorder(
//                 color: AppPallete.borderColor,
//                 dashPattern: [10, 4],
//                 radius: const Radius.circular(10),
//                 borderType: BorderType.RRect,
//                 strokeCap: StrokeCap.round,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   child: const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.folder_open,
//                         size: 15,
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Text(
//                         'Select your image',
//                         style: TextStyle(fontSize: 15),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10,),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children:
//                     ['Technology', 'Business', 'Programmng', 'Entertaiment']
//                         .map(
//                           (e) => Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Chip(
//                               label: Text(e),
//                               side: const BorderSide(
//                                 color: AppPallete.borderColor
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
