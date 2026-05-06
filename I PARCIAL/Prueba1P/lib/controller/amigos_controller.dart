import '../model/amigos_model.dart';

class AmigosController {
  Map<String, dynamic> procesarAmigos(String inputA, String inputB) {
    // RN-01: Validar campos vacíos
    if (inputA.trim().isEmpty || inputB.trim().isEmpty) {
      return {"error": "Por favor ingrese los dos números"};
    }

    // RN-02: Intentar parsear a entero
    int? a = int.tryParse(inputA.trim());
    int? b = int.tryParse(inputB.trim());

    if (a == null || b == null) {
      return {"error": "Por favor ingrese solo números enteros"};
    }

    // RN-02: Validar que sean positivos
    if (a <= 0 || b <= 0) {
      return {"error": "Los números deben ser enteros positivos (mayores que cero)"};
    }

    // Todo válido: delegar al modelo
    return AmigosModel.verificarAmigos(a, b);
  }
}