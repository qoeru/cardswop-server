import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (request.method.value == 'POST') {
    final body = await request.body();
    final bodyAsIntList =
        ((jsonDecode(body) as Map<String, dynamic>)['img'] as List<dynamic>)
            .cast<int>();
    final img = Uint8List.fromList(bodyAsIntList);

    var imgName = DateTime.now().millisecondsSinceEpoch.toString();

    if (request.headers['type'] == 'png') {
      imgName = '$imgName.png';
      await File('public/cards_images/$imgName').writeAsBytes(img);
    } else if (request.headers['type'] == 'jpg') {
      imgName = '$imgName.jpg';
      await File('public/cards_images/$imgName').writeAsBytes(img);
    } else {
      return Response(statusCode: 415);
    }

    return Response(statusCode: 201, body: jsonEncode({'img_path': imgName}));
  }

  return Response();
}
