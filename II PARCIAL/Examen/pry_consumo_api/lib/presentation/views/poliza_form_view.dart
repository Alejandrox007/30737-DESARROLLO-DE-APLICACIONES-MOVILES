import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/poliza_viewmodel.dart';
import '../../domain/entities/poliza.dart';

class PolizaFormView extends StatefulWidget {
  final VoidCallback? onSubmitSuccess;
  const PolizaFormView({super.key, this.onSubmitSuccess});

  @override
  State<PolizaFormView> createState() => _PolizaFormViewState();
}

class _PolizaFormViewState extends State<PolizaFormView> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();
  final _clienteController = TextEditingController();
  final _fechaInicioController = TextEditingController();
  final _fechaVencimientoController = TextEditingController();
  final _valorController = TextEditingController();
  
  String _tipoSeguro = "Vida";
  final List<String> _tiposSeguro = ["Vida", "Auto", "Salud", "Hogar", "Otros"];

  @override
  void dispose() {
    _codigoController.dispose();
    _clienteController.dispose();
    _fechaInicioController.dispose();
    _fechaVencimientoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = Provider.of<PolizaViewModel>(context, listen: false);

    final newPoliza = Poliza(
      id: "", // El backend asignará el ID real
      codigo: _codigoController.text.trim(),
      cliente: _clienteController.text.trim(),
      tipoSeguro: _tipoSeguro,
      fechaInicio: _fechaInicioController.text.trim(),
      fechaVencimiento: _fechaVencimientoController.text.trim(),
      valorAsegurado: double.parse(_valorController.text.trim()),
    );

    final success = await vm.createPoliza(newPoliza);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? "Póliza registrada con éxito"
              : "Error al registrar la póliza"),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );

      if (success) {
        _formKey.currentState!.reset();
        _codigoController.clear();
        _clienteController.clear();
        _fechaInicioController.clear();
        _fechaVencimientoController.clear();
        _valorController.clear();
        setState(() {
          _tipoSeguro = "Vida";
        });
        
        if (widget.onSubmitSuccess != null) {
          widget.onSubmitSuccess!();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Registrar Nueva Póliza",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              // Código de póliza
              TextFormField(
                controller: _codigoController,
                decoration: const InputDecoration(
                  labelText: "Código de Póliza",
                  prefixIcon: Icon(Icons.qr_code),
                  border: OutlineInputBorder(),
                  hintText: "Ej: POL-2026-003",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingrese el código";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Cliente
              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(
                  labelText: "Nombre del Cliente",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  hintText: "Ej: Juan Pérez",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingrese el cliente";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tipo de seguro
              DropdownButtonFormField<String>(
                value: _tipoSeguro,
                decoration: const InputDecoration(
                  labelText: "Tipo de Seguro",
                  prefixIcon: Icon(Icons.shield_outlined),
                  border: OutlineInputBorder(),
                ),
                items: _tiposSeguro.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _tipoSeguro = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Fecha Inicio
              TextFormField(
                controller: _fechaInicioController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Fecha de Inicio",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  hintText: "YYYY-MM-DD",
                ),
                onTap: () => _selectDate(context, _fechaInicioController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor seleccione la fecha de inicio";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Fecha Vencimiento
              TextFormField(
                controller: _fechaVencimientoController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Fecha de Vencimiento",
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(),
                  hintText: "YYYY-MM-DD",
                ),
                onTap: () => _selectDate(context, _fechaVencimientoController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor seleccione la fecha de vencimiento";
                  }
                  // Validar que vencimiento sea después de inicio
                  if (_fechaInicioController.text.isNotEmpty) {
                    final start = DateTime.tryParse(_fechaInicioController.text);
                    final end = DateTime.tryParse(value);
                    if (start != null && end != null && end.isBefore(start)) {
                      return "La fecha de vencimiento debe ser posterior a la de inicio";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Valor Asegurado
              TextFormField(
                controller: _valorController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Valor Asegurado",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                  hintText: "Ej: 120000.50",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingrese el valor asegurado";
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) {
                    return "Ingrese un valor numérico mayor a 0";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botón Guardar
              ElevatedButton(
                onPressed: vm.loading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: vm.loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Registrar Póliza",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
