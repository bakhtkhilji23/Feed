// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../../../config/wp_config.dart';
// import '../../../../core/models/article.dart';
//
// class Inspire extends StatefulWidget {
//   const Inspire({Key? key}) : super(key: key);
//
//   @override
//   State<Inspire> createState() => _InspireState();
// }
//
// class _InspireState extends State<Inspire> {
//   bool isLoading = false;
//   Future<ArticleModel?> getPost() async {
//     print("object");
//     setState(() {
//       isLoading = true;
//     });
//     final client = http.Client();
//     var rng = Random();
//     var randomNumber = rng.nextInt(10);
//     //use randomNumber instead of 10 on the next line
//     String url = 'https://${WPConfig.url}/wp-json/wl/v1/posts/180';
//     try {
//       final response = await client.post(Uri.parse(url));
//       if (response.statusCode == 200) {
//         setState(() {
//           // print(jsonDecode(response.body)["post"]);
//           PostModel refreshedPost =
//               PostModel.fromMap(jsonDecode(response.body)['post']);
//           articleToshow = articleToshow.copyWith(
//             title: refreshedPost.post_title,
//             heroTag: refreshedPost.post_title,
//             content: refreshedPost.post_content,
//             id: refreshedPost.id,
//             date: refreshedPost.post_date,
//             commentCount: refreshedPost.comment_count,
//           );
//         });
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       // Fluttertoast.showToast(msg: e.toString());
//     } finally {
//       client.close();
//       isLoading = false;
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
