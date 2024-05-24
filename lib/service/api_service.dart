import 'package:dio/dio.dart';
import 'package:mini_project/env/env.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/model/alamat_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<KaosModel>> getAllKaos() async {
    try {
      final response = await _dio.get(Env.apiKey);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((item) => KaosModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<KaosModel>> getKaosById(String? kaosId) async {
    try {
      final response = await _dio.get(Env.apiKey);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData
            .map((item) => KaosModel.fromJson(item))
            .where((kaos) => kaos.id == kaosId)
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<AlamatModel>> getAlamatList() async {
    try {
      final response = await _dio.get(Env.apiKey2);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((alamat) => AlamatModel.fromJson(alamat)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> submitAlamat(Map<String, dynamic> alamatModel) async {
    try {
      final response = await _dio.post(Env.apiKey2, data: alamatModel);
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to submit address: $e');
    }
  }

  Future<bool> deleteAlamat(String? id) async {
    try {
      final response = await _dio.delete('${Env.apiKey2}/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
