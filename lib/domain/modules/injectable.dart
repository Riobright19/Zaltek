import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zaltek/domain/modules/injectable.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  $initGetIt(getIt, environment: Environment.prod);
}
