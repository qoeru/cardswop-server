import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'GET') {
    final swopper = await db.getSwopperByUid(uid: id);

    if (swopper == null) {
      return Response(statusCode: 404);
    }

    return Response(body: jsonEncode(swopper.toJson()));
  }

  if (method == 'POST') {
    final body = await request.body(); //user update
    final swopper = await db.updateSwopper(
      json: jsonDecode(body) as Map<String, dynamic>,
      uid: id,
    );

    if (swopper == null) {
      return Response(statusCode: 404);
    }

    return Response(body: jsonEncode(swopper.toJson()));
  }

  return Response();
}
