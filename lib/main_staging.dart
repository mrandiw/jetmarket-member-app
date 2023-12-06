import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jetmarket/main.dart';
import 'utils/path/environment.dart';

Future<void> main() async {
  await dotenv.load(fileName: environmentPath.staging).then((value) {
    kAppEnvironment = dotenv.env['NAME']!;
    kBaseUrl = dotenv.env['BASE_URL']!;
    kBulkUrl = dotenv.env['BULK_URL']!;
    apiKey = dotenv.env['API_KEY']!;
    kApiUrl = dotenv.env['MAPS_URL']!;
    kIsDevelopment = true;
    debugPrint("RUNNING ENVIRONMENT => $kAppEnvironment");
    debugPrint("BASE URL : $kBaseUrl");
    debugPrint("BULK URL : $kBulkUrl");
    start();
  });
}
