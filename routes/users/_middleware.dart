import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';
import '../../localenv.dart';

final db = Database(
  host: HOST,
  port: PORT,
  database: DATABASE,
  user: USERNAME,
  password: PASSWORD,
  useSSL: false,
);

Handler middleware(Handler handler) {
  return handler.use(
    provider<Database>((context) => db),
  );
}
