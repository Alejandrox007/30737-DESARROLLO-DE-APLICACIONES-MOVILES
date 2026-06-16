import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../models/poliza_model.dart';

class PolizaApiDatasource {
  static String get _baseUrl {
    if (kIsWeb) return "http://localhost:8000/api/polizas";
    return Platform.isAndroid 
        ? "http://10.0.2.2:8000/api/polizas" 
        : "http://localhost:8000/api/polizas";
  }

  final String baseUrl = _baseUrl;

  Future<List<PolizaModel>> getPolizas() async {
    final url = Uri.parse(baseUrl);
    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception("Error al obtener las pólizas");
    }

    final List data = jsonDecode(resp.body);
    return data.map((e) => PolizaModel.fromJson(e)).toList();
  }

  Future<PolizaModel> createPoliza(PolizaModel poliza) async {
    final url = Uri.parse(baseUrl);
    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(poliza.toJson()),
    );

    if (resp.statusCode != 201) {
      throw Exception("Error al registrar la póliza");
    }

    return PolizaModel.fromJson(jsonDecode(resp.body));
  }

  Future<PolizaModel> updatePoliza(PolizaModel poliza) async {
    final url = Uri.parse("$baseUrl/${poliza.id}");
    final resp = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(poliza.toJson()),
    );

    if (resp.statusCode != 200) {
      throw Exception("Error al actualizar la póliza");
    }

    return PolizaModel.fromJson(jsonDecode(resp.body));
  }

  Future<void> deletePoliza(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final resp = await http.delete(url);

    if (resp.statusCode != 200) {
      throw Exception("Error al eliminar la póliza");
    }
  }
}
