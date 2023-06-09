import 'package:cardswop_shared/cardswop_shared.dart';
import 'package:dart_frog/dart_frog.dart';
// ignore: depend_on_referenced_packages
import 'package:orm/logger.dart';
import '../localenv.dart';

final database = Prisma(
  prisma: PrismaClient(
    stdout: Event.values, // print all events to the console
    datasources: const Datasources(
      db: DATABSE_URL,
    ),
  ),
);

Handler middleware(Handler handler) {
  return handler.use(provider<Prisma>((context) => database));
}
