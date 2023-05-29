import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';
import '../../localenv.dart';

final db = Database(
  host: HOST,
  port: 5432,
  database: 'cardswop',
  user: 'postgres',
  password: 'pills',
  useSSL: false,
);

Handler middleware(Handler handler) {
  return handler.use(
    provider<Database>((context) => db),
  );
}
