import 'dart:io';

checkInternet() async {
  try {
    var res = await InternetAddress.lookup("google.com");
    if (res.isNotEmpty) {
      return true;
    }
  } on SocketException catch (e) {
    return false;
  }
}
