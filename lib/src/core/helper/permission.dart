// import 'package:permission_handler/permission_handler.dart';

// Future<bool> checkCameraPermission() async {
//   final cameraStatus = await Permission.camera.status;

//   switch (cameraStatus) {
//     case PermissionStatus.denied:
//       final requestPermission = await Permission.camera.request();

//       return requestPermission.isGranted;

//     case PermissionStatus.granted:
//       // TODO: Handle this case.
//       break;

//     case PermissionStatus.permanentlyDenied:
//       // TODO: Handle this case.
//       break;

//     default:
//       return false;
//   }
// }
