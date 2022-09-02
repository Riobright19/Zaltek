// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import '../../implementation/item_listing_impl.dart' as _i6;
import '../client/urls.dart' as _i3;
import '../model/item_list_facde.dart' as _i5;
import 'modules.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  gh.lazySingleton<_i3.ApiUrls>(() => _i3.ApiUrls());
  gh.lazySingleton<_i4.Client>(() => httpModule.httpClient);
  gh.lazySingleton<_i5.ItemListingFacade>(
      () => _i6.ItemListingImpl(get<_i3.ApiUrls>()));
  return get;
}

class _$HttpModule extends _i7.HttpModule {}
