import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions {
  const factory NetworkExceptions.noInternetException() = NoInternetException;
  const factory NetworkExceptions.addressNotFoundException(
      {required String errorMessage}) = AddressNotFoundException;
  const factory NetworkExceptions.validationException(
      {required String errorMessage}) = ValidationException;
  const factory NetworkExceptions.unAuthorizedException(
      {required String errorMessage}) = UnAuthorizedException;
  const factory NetworkExceptions.notFoundException(
      {required String errorMessage}) = NotFoundException;
  const factory NetworkExceptions.mongoException(
      {required String errorMessage}) = MongoException;
  const factory NetworkExceptions.internalServerException(
      {required String errorMessage}) = InternalServerException;
  const factory NetworkExceptions.serverOverloadedException(
      {required String errorMessage}) = ServerOverloadedException;
  const factory NetworkExceptions.apiErrorMessageException(
      {required String errorMessage}) = ApiErrorMessageException;
  const factory NetworkExceptions.userCancelledRequestException() =
      UserCancelledRequestException;
  const factory NetworkExceptions.requestTimeOutException() =
      RequestTimeOutException;
  const factory NetworkExceptions.insufficentBalance() = InsufficentBalance;
  const factory NetworkExceptions.unKnownException(
      {required String errorMessage}) = UnKnownException;
  const factory NetworkExceptions.databaseException(
      {required String errorMessage}) = DatabaseException;
}

NetworkExceptions getExceptionFromStatusCode(int code) {
  final exceptionMap = {
    404: const NetworkExceptions.notFoundException(errorMessage: 'NotFound')
  };
  if (exceptionMap.containsKey(code)) {
    return exceptionMap[code]!;
  } else {
    return const NetworkExceptions.unKnownException(
        errorMessage: 'Unknown Error');
  }
}

String getExceptionMessageFromNetworkExceptions(NetworkExceptions exceptions) {
  var failureMessage = '';
  if (exceptions is NoInternetException) {
    failureMessage = 'Not connected to Internet';
  } else if (exceptions is AddressNotFoundException) {
    failureMessage = 'Address Not Found';
  } else if (exceptions is ValidationException) {
    failureMessage = '${exceptions.errorMessage}';
  } else if (exceptions is UnAuthorizedException) {
    failureMessage = 'Unauthorized. Please Sign In Again';
  } else if (exceptions is NotFoundException) {
    failureMessage = 'Item not found';
  } else if (exceptions is MongoException ||
      exceptions is InternalServerException ||
      exceptions is ServerOverloadedException ||
      exceptions is DatabaseException) {
    failureMessage = 'Server Error. Try again later';
  } else if (exceptions is ApiErrorMessageException) {
    failureMessage = exceptions.errorMessage;
  } else if (exceptions is UserCancelledRequestException) {
    failureMessage = 'User cancelled sign in';
  } else if (exceptions is RequestTimeOutException) {
    failureMessage = 'Request time out';
  } else if (exceptions is InsufficentBalance) {
    failureMessage = 'Insufficient Coins. Play more to earn more coins';
  } else if (exceptions is UnKnownException) {
    failureMessage = 'Unknown error occured. Try again later';
  } else if (exceptions is UnKnownException) {
    failureMessage = 'thread not found';
  }
  return failureMessage;
}
