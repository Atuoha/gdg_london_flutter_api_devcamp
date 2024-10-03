import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/post.dart';

part 'post_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET("/posts")
  Future<List<Post>> getPosts();

  @POST("/posts")
  Future<Post> createPost(@Body() Post post);

  @PUT("/posts/{id}")
  Future<Post> updatePost(@Path("id") int id, @Body() Post post);

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int id);
}
