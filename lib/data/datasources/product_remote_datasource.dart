import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:resto_fic14/core/constants/variable.dart';
import 'package:resto_fic14/data/datasources/auth_local_datasource.dart';
import 'package:resto_fic14/data/models/response/product_response_model.dart';

class ProductRemoteDataSource {
  Future<Either<String, ProductResponseModel>> getProduct() async {
    final url = Uri.parse('${Variable.baseUrl}/api/api-products/');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(headers: {
      'Authorization': 'Bearer ${authData.token}',
    }, url);
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('failed to get product');
    }
  }
}
