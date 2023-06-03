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

  log('request');

  final body = await request.body();

  log('USERS ENDPOINT: Got request body');

  if (method == 'POST') {
    // log('USERS ENDPOINT, POST: Post method detected');
    final requestUser = jsonDecode(body) as Map<String, dynamic>;

    await db.users.insertOne(
      UserInsertRequest.jsonDecode(
        requestUser,
      ),
    );
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
