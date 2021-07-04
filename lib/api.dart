import 'dart:typed_data';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudApi{
  final auth.ServiceAccountCredentials _credentials;
  auth.AutoRefreshingAuthClient _client;

  CloudApi( String json)
    : _credentials = auth.ServiceAccountCredentials.fromJson(json);
  
  Future<ObjectInfo> save(String name, Uint8List imgBytes) async{
    try {
      if(_client == null)
        _client = await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);
      
      var storage = Storage(_client, 'foodswap');
      var bucket = storage.bucket('mybucket29621');
      
      final type = lookupMimeType(name);
      return await bucket.writeBytes(name, imgBytes, metadata: ObjectMetadata(
        contentType: type,
      ));
    } on Exception catch (e) {
          // TODO
          print("error: "+e.toString());
    }
  }
}
CloudApi api;
// void saveImage()async{
//     final response = await api.save(imageName, imgBytes);
//     print(response.downloadLink);
//   }