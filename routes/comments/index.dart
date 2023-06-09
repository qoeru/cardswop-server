import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'POST') {
    // post single comment
    final body = await request.body();
    final comment = await db.createCommentUnderCard(
      Comment.fromJson(jsonDecode(body) as Map<String, dynamic>),
    );

    if (comment == null) {
      return Response(statusCode: 404, body: 'your mistake');
    }

    // 200
    return Response(body: jsonEncode(comment.toJson()));
  }

  return Response();
}
