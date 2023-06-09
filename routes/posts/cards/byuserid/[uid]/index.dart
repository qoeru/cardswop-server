import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

// /posts/cards/[id]

FutureOr<Response> onRequest(RequestContext context, String uid) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'GET') {
    final cards = await db.getUserCards(uid);

    if (cards == null) {
      return Response(statusCode: 404, body: 'your mistake');
    }

    Map<String, dynamic> json = {};

    for (var i = 0; i < cards.length; i++) {
      json[i.toString()] = cards.elementAt(i).toJson();
    }

    return Response(statusCode: 201, body: jsonEncode(json));
  }

  return Response();
}
