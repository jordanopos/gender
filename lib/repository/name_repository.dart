import 'package:podio/models/gender.dart';
import 'package:http/http.dart' as http;

abstract class GenderRepo {
  Future<GenderResult> getGender(String name);
}

class GenderImpl extends GenderRepo {
  @override
  Future<GenderResult> getGender(String name) async {
    String baseUrl = 'https://api.genderize.io?name=$name';

    var response = await http.get(baseUrl);
    
    GenderResult genderResult = genderFromJson(response.body);

    return genderResult;
  }
}
