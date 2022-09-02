import 'package:injectable/injectable.dart';

@lazySingleton
class ApiUrls {
  String get _devUrl => 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';

  /// Base Url
  String get getItems => _devUrl;
}
