import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:domain/db.dart';
import 'package:stormberry/stormberry.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Database>();

  log('request');

  if (method == 'POST') {
    log('post nethod');
    final body = await request.body();
    log('post method, got body');
    await db.users.insertOne(
      UserInsertRequest.jsonDecode(
        jsonDecode(body) as Map<String, dynamic>,
      ),
    );
    log('post method, inserted new row');

    return Response();
  }

  // if (method == 'GET') {
  //   final params = request.uri.queryParameters;
  //   return
  // }

  return Response(body: 'This is a new route!');
}
