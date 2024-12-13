// Conditional import based on the platform
export 'email_sender_mobile.dart' 
  if (dart.library.html) 'email_sender_web.dart';
