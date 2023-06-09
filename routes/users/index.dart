import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'POST') {
    final body = await request.body();

    final requestUser = jsonDecode(body) as Map<String, dynamic>;

    final swopper = await db.createSwopper(json: requestUser);

    if (swopper == null) {
      return Response(statusCode: 404);
    }

    log('USERS ENDPOINT, POST: Inserted new row');

    return Response(statusCode: 201, body: jsonEncode(swopper.toJson()));
  }

  return Response();
}
