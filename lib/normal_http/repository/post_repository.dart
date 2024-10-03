import '../api/post_service.dart';
import '../model/post.dart';

class PostNormalRepository {
  final PostService postService;

  PostNormalRepository(this.postService);

  Future<List<Post>> fetchPosts() => postService.fetchPosts();

  Future<Post> createPost(Post post) => postService.createPost(post);

  Future<Post> updatePost(int id, Post post) =>
      postService.updatePost(id, post);

  Future<void> deletePost(int id) => postService.deletePost(id);
}
