import 'package:flutter/material.dart';
import '../controller/amigos_controller.dart';


// ÁTOMOS


class TituloLabel extends StatelessWidget {
  final String text;
  const TituloLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
}

class InfoLabel extends StatelessWidget {
  final String text;
  const InfoLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(fontSize: 14, color: Colors.black54));
}

class NumeroField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const NumeroField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: hint,
      border: const OutlineInputBorder(),
    ),
  );
}

class BotonPrimario extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BotonPrimario({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    child: Text(text),
  );
}

class ResultadoBadge extends StatelessWidget {
  final bool sonAmigos;

  const ResultadoBadge({super.key, required this.sonAmigos});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: sonAmigos ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: sonAmigos ? Colors.green : Colors.red,
          width: 0.5,
        ),
      ),
      child: Text(
        sonAmigos ? '¡Son números amigos!' : 'No son números amigos',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: sonAmigos ? Colors.green.shade800 : Colors.red.shade800,
        ),
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String mensaje;
  const ErrorText(this.mensaje, {super.key});

  @override
  Widget build(BuildContext context) => Text(
    mensaje,
    style: const TextStyle(color: Colors.red, fontSize: 14),
  );
}


// MOLÉCULAS


// Molécula: par de campos de entrada lado a lado
class NumerosInput extends StatelessWidget {
  final TextEditingController ctrlA;
  final TextEditingController ctrlB;

  const NumerosInput({super.key, required this.ctrlA, required this.ctrlB});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: NumeroField(controller: ctrlA, hint: 'Número A')),
        const SizedBox(width: 12),
        Expanded(child: NumeroField(controller: ctrlB, hint: 'Número B')),
      ],
    );
  }
}

// Molécula: detalle de divisores (muestra sumaA y sumaB)
class DetalleResultado extends StatelessWidget {
  final Map<String, dynamic> resultado;

  const DetalleResultado({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel('Suma de divisores de ${resultado["a"]}: ${resultado["sumaA"]}'),
          const SizedBox(height: 4),
          InfoLabel('Suma de divisores de ${resultado["b"]}: ${resultado["sumaB"]}'),
        ],
      ),
    );
  }
}


// ORGANISMO


class AmigosCard extends StatefulWidget {
  const AmigosCard({super.key});

  @override
  State<AmigosCard> createState() => _AmigosCardState();
}

class _AmigosCardState extends State<AmigosCard> {
  final _ctrlA = TextEditingController();
  final _ctrlB = TextEditingController();

  String? _error;
  Map<String, dynamic>? _resultado;

  final _controller = AmigosController();

  void _verificar() {
    final res = _controller.procesarAmigos(_ctrlA.text, _ctrlB.text);
    setState(() {
      if (res.containsKey("error")) {
        _error = res["error"];
        _resultado = null;
      } else {
        _error = null;
        _resultado = res;
      }
    });
  }

  void _limpiar() {
    setState(() {
      _ctrlA.clear();
      _ctrlB.clear();
      _error = null;
      _resultado = null;
    });
  }

  @override
  void dispose() {
    _ctrlA.dispose();
    _ctrlB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TituloLabel('Verificar números amigos'),
            const SizedBox(height: 6),
            const InfoLabel('Ingrese dos números enteros positivos'),
            const SizedBox(height: 14),
            NumerosInput(ctrlA: _ctrlA, ctrlB: _ctrlB),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: BotonPrimario(text: 'Verificar', onPressed: _verificar),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _limpiar,
                    child: const Text('Limpiar'),
                  ),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              ErrorText(_error!),
            ],
            if (_resultado != null) ...[
              const SizedBox(height: 14),
              ResultadoBadge(sonAmigos: _resultado!["sonAmigos"]),
              const SizedBox(height: 10),
              DetalleResultado(resultado: _resultado!),
            ],
          ],
        ),
      ),
    );
  }
}


// PÁGINA

class AmigosPage extends StatelessWidget {
  const AmigosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Números Amigos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: const AmigosCard(),
        ),
      ),
    );
  }
}