import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../normal_http/api/post_service.dart';
import '../normal_http/model/post.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final PostService postService = PostService();
  final Random _random = Random();
  Post? post;
  bool isPosting = false;

  void createPost() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isPosting = true;
      });
      Post newPost = Post(
        id: _random.nextInt(10000) + 101,
        userId: 1,
        title: _titleController.text,
        body: _bodyController.text,
      );
      try {
        Post createdPost = await postService.createPost(newPost);
        setState(() {
          post = createdPost;
        });
        if (kDebugMode) {
          print(post!.body);
        }
        setState(() {
          isPosting = false;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title cannot be empty';
                  }

                  if (value.length < 3) {
                    return 'Title must be greater than 3 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Body cannot be empty';
                  }

                  if (value.length < 10) {
                    return 'Body must be greater than 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  createPost();
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              isPosting
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),
              post != null
                  ? Column(
                      children: [
                        const Divider(),
                        const SizedBox(height: 10),
                        Text(
                          'New post created:',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Title: ${post!.title}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Body: ${post!.body}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
