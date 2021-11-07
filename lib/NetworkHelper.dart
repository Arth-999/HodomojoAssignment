import 'package:http/http.dart' as http;
import 'dart:convert';

//url for the given API
const url =
    'http://website-bucket-12234.s3-website-us-east-1.amazonaws.com/api.json';

//Function used to get data from API url
class NetworkHelper {
  Future getdata() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
      print('ERROR');
    }
  }
}