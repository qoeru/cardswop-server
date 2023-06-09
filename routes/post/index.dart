import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cardswop_shared/db.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Database>();

  if (method == 'POST') {
    final body = await request.body();
    final requestPost = jsonDecode(body) as Map<String, dynamic>;
    if (request.headers['post-type'] == 'card') {
      await db.cards.insertOne(CardInsertRequest.jsonDecode(requestPost));
    }
    if (request.headers['post-type'] == 'series') {
      await db.serieses.insertOne(SeriesInsertRequest.jsonDecode(requestPost));
    }

    log('USERS ENDPOINT, POST: Inserted new row');

    return Response(statusCode: 201);
  }

  if (method == 'PUT') {
    final uidFromRequest = jsonDecode(body) as Map<String, dynamic>;

    final user = await db.users.queryUser(uidFromRequest['uid'] as String);
    if (user == null) {
      return Response(
        statusCode: 404,
        body: 'user-not-found',
      );
    }

    // ignore: avoid_redundant_argument_values
    return Response(
      body: jsonEncode(user.jsonEncode()),
    );
  }
  return Response();
}
