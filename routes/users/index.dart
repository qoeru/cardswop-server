import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:shared/db.dart';
import 'package:stormberry/stormberry.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Database>();

  if (method == 'POST') {
    final body = await request.body();
    await db.users.insertOne(
      UserViewQueryable().decode(jsonDecode(body) as TypedMap)
          as UserInsertRequest,
    );

    return Response();
  }

  // if (method == 'GET') {
  //   final params = request.uri.queryParameters;
  //   return
  // }

  return Response(body: 'This is a new route!');
}
