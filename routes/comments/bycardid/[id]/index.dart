import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'GET') {
    final comments = await db.getCardComments(id);

    if (comments == null) {
      return Response(statusCode: 404, body: 'your mistake');
    }

    Map<String, dynamic> json = {};

    for (var i = 0; i < comments.length; i++) {
      json[i.toString()] = comments.elementAt(i).toJson();
    }

    // 200
    return Response(body: jsonEncode(json));
  }

  return Response();
}
