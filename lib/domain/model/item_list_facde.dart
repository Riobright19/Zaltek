import 'package:dartz/dartz.dart';
import 'package:zaltek/domain/exceptions/network_exceptions.dart';
import 'package:zaltek/domain/model/item_model.dart';

abstract class ItemListingFacade {
  Future<Either<NetworkExceptions, List<ItemListingModel>>> getItemList();
}
