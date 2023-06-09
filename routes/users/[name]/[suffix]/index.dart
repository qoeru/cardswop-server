import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String name,
  String suffix,
) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'GET') {
    final swopper =
        await db.getSwopperByName(name: name, suffix: int.parse(suffix));

    if (swopper == null) {
      return Response(statusCode: 404);
    }

    return Response(body: jsonEncode(swopper.toJson()));
  }

  return Response();
}
