import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

// /posts/cards/[id]

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'GET') {
    final card = await db.getCard(cardId: id);

    if (card == null) {
      return Response(statusCode: 404, body: 'your mistake');
    }

    // 200
    return Response(body: jsonEncode(card.toJson()));
  }

  return Response();
}
