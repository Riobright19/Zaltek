import 'dart:convert';

import 'package:zaltek/domain/client/api_client.dart';
import 'package:zaltek/domain/client/urls.dart';
import 'package:zaltek/domain/exceptions/network_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:zaltek/domain/model/item_list_facde.dart';
import 'package:injectable/injectable.dart';
import 'package:zaltek/domain/model/item_model.dart';

@LazySingleton(as: ItemListingFacade)
class ItemListingImpl implements ItemListingFacade {
  final ApiUrls _urls;

  ItemListingImpl(this._urls);

  @override
  Future<Either<NetworkExceptions, List<ItemListingModel>>>
      getItemList() async {
    final response = await Postman.sendGetRequest(
      _urls.getItems,
    );
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      List temp = (jsonMap as List)
          .map((itemWord) => ItemListingModel.fromJson(itemWord))
          .toList();
      // final result = ItemListingModel.fromJson(jsonDecode(response.body));
      return right(temp as List<ItemListingModel>);
    } else {
      return left(const NetworkExceptions.noInternetException());
    }
  }
}
