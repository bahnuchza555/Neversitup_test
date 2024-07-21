import 'package:flutter_dotenv/flutter_dotenv.dart';

String appName = dotenv.get('APP_NAME');
String endPointPath = dotenv.get('END_POINT_PATH');
String endPointAPI = dotenv.get('END_POINT_API');
