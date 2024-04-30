import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:resto_fic14/core/constants/variable.dart';
import 'package:resto_fic14/data/datasources/auth_local_datasource.dart';
import 'package:resto_fic14/data/models/response/auth_response_model.dart';

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variable.baseUrl}/api/login');
    final response =
        await http.post(url, body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Login');
    }
  }

  Future<Either<String, bool>> logout() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final url = Uri.parse('${Variable.baseUrl}/api/logout');
    final response = await http.post(headers: {
      'Authorization': 'Bearer ${authData.token}',
    }, url);
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to logout');
    }
  }
}
