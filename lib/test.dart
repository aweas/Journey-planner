import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  Tester()..funct()..funct2();
}

class Tester {
  final Logger log = new Logger("Tester");

  void funct() {
    log.shout('SHOUT');
  }

  void funct2() {
    log.severe('severe');
    log.fine([1, 2, 3, 4, 5].map((e) => e * 4).join("-"));
  }
}