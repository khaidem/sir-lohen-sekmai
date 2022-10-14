import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/model/model.dart';

// This is necessary for the generator to work.
part "garbages.service.chopper.dart";

@ChopperApi(baseUrl: "/garbages")
abstract class GarbagesService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static GarbagesService create({ChopperClient? client}) =>
      _$GarbagesService(client);

  ///
  /// body Payload
  /// {
  ///     "jwt_token": "thisWillBeToken"
  /// }
  @Post()
  Future<Response<GarbagesCollectionResponse>> collected(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: '/customcreate')
  @multipart
  Future<Response<GarbagesCollectionResponse>> uploadPhoto(
    @PartFile('image') String imagePath,
    @Part("collection_date") String collectedOn,
    @Part("customer_no") String customerNo,
    @Part("latitude") String latitude,
    @Part("longitude") String longitude,
  );
}
