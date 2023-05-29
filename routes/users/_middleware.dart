import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

final db = Database(
  host: 'db',
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
