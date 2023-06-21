import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;

import '../../abdulrahman/class/chechinternet.dart';

class HttpData {
  static postdata(String linkurl, Map data) async {
    if (await checkInternet()) {
      var res = await http.post(Uri.parse(linkurl), body: data);

      Map resbody = jsonDecode(res.body);
      print("======$resbody");
      return resbody;
    }
  }

  static getData(String url) async {
    if (await checkInternet()) {
      var res = await http.get(Uri.parse(url));
      var resbody = jsonDecode(res.body);
      print("======$resbody");
      return resbody;
    }
  }

  static postRequestWithFile(String url, Map data, File file) async {
    if (await checkInternet()) {
      var res = await http.MultipartRequest("POST", Uri.parse(url));
      var lentgh = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multipartFile = http.MultipartFile("file", stream, lentgh,
          filename: basename(file.path));
      res.files.add(multipartFile);
      data.forEach((key, value) {
        res.fields[key] = value;
      });

      var myrequest = await res.send();
      var response = await http.Response.fromStream(myrequest);
      if (myrequest.statusCode == 200) {
        Map resbody = jsonDecode(response.body);
        print("======$resbody");
        return resbody;
      } else {
        print("Erorr ${myrequest.statusCode}");
      }
    }
  }
}
