import 'package:pigeon/objc_generator.dart' show ObjcOptions;
import 'package:pigeon/java_generator.dart' show JavaOptions;
import 'package:pigeon/pigeon.dart';

// @HostRemoteApi()
// abstract class Apple {}

@HostRemoteApi()
abstract class Camera {
  void release(Camera camera);
  void startPreview(Camera camera);
  void stopPreview(Camera camera);
  void setDisplayOrientation(Camera camera, int degrees);
  int attachPreviewTexture(Camera camera);
  void releasePreviewTexture(Camera camera);
}

// class SearchRequest {
//   String? query;
// }
//
// class SearchReply {
//   String? result;
// }
//
// @HostApi()
// abstract class Api {
//   SearchReply search(SearchRequest request);
//   SearchReply poop(SearchRequest request);
// }

void configurePigeon(PigeonOptions opts) {
  opts.dartOut = 'lib/messages.dart';
  // opts.objcHeaderOut = 'ios/Classes/messages.h';
  // opts.objcSourceOut = 'ios/Classes/messages.m';
  // opts.objcOptions = ObjcOptions(prefix: 'FLT');
  opts.javaOut =
      'android/src/main/java/com/example/pigeon_typechannel/Messages.java';
  opts.javaOptions = JavaOptions(package: 'com.example.pigeon_typechannel');
}
