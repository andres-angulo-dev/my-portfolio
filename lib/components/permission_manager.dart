import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  // Request permission to access storage
  static Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  // Request permission to manage storage (Android 11+)
  static Future<bool> requestManageStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
    }
    return status.isGranted;
  }

  // Request permission to access the camera
  static Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  // Request permission to access the microphone
  static Future<bool> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (status.isDenied) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }

  // Request permission to access video files
  static Future<bool> requestVideoPermission() async {
    PermissionStatus status = await Permission.videos.status;
    if (status.isDenied) {
      status = await Permission.videos.request();
    }
    return status.isGranted;
  }

  // Request permission to access audio files
  static Future<bool> requestAudioPermission() async {
    PermissionStatus status = await Permission.audio.status;
    if (status.isDenied) {
      status = await Permission.audio.request();
    }
    return status.isGranted;
  }

}
