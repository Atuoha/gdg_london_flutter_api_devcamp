import '../data/services/post_service.dart';
import '../model/post.dart';

class PostRepository {
  final PostService postService;

  PostRepository(this.postService);

  Future<List<Post>> fetchPosts() => postService.getPosts();

  Future<Post> createPost(Post post) => postService.createPost(post);

  Future<Post> updatePost(int id, Post post) =>
      postService.updatePost(id, post);

  Future<void> deletePost(int id) => postService.deletePost(id);
}
