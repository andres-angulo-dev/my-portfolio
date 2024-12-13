// Conditional import based on the platform
export 'download_cv_button_mobile.dart' 
  if (dart.library.html) 'download_cv_button_web.dart';
