import 'dart:async';
import 'dart:convert';
import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';

// /posts/cards/

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method.value;

  final db = context.read<Prisma>();

  if (method == 'POST') {
    final body = await request.body();
    final requestCard = jsonDecode(body) as Map<String, dynamic>;

    final newCard = await db.createCard(card: Card.fromJson(requestCard));

    if (newCard == null) {
      // TODO: посмотреть какой тут статус-код
      return Response(statusCode: 404);
    }

    return Response(statusCode: 201, body: jsonEncode(newCard.toJson()));
  }

  if (method == 'GET') {
    final queryParameters = request.uri.queryParametersAll;

    final listOfString = queryParameters['limitednesses']!.first.split(',');

    final limitednesses = List<int>.generate(
      listOfString.length,
      (index) => int.parse(listOfString[index]),
    );

    // ignore: avoid_bool_literals_in_conditional_expressions
    final isDesc = queryParameters['isDesc'] != null
        ? queryParameters['isDesc']!.first.toLowerCase() == 'true'
        : false;
    final take = queryParameters['take'] != null
        ? int.parse(queryParameters['take']!.first)
        : 20;

    final cards = await db.getFeed(limitednesses, isDesc, take);

    if (cards == null) {
      return Response(statusCode: 404);
    }

    Map<String, dynamic> json = {};

    for (var i = 0; i < cards.length; i++) {
      json[i.toString()] = cards.elementAt(i).toJson();
    }

    return Response(statusCode: 201, body: jsonEncode(json));
  }

  return Response();
}
