import 'package:flutter/material.dart';
import '../../domain/entities/poliza.dart';

class PolizaDetailPage extends StatelessWidget {
  const PolizaDetailPage({super.key});

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'vida':
        return Colors.green;
      case 'auto':
        return Colors.blue;
      case 'salud':
        return Colors.orange;
      case 'hogar':
        return Colors.purple;
      default:
        return Colors.teal;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'vida':
        return Icons.favorite;
      case 'auto':
        return Icons.directions_car;
      case 'salud':
        return Icons.local_hospital;
      case 'hogar':
        return Icons.home;
      default:
        return Icons.security;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Poliza poliza = ModalRoute.of(context)!.settings.arguments as Poliza;
    final typeColor = _getTypeColor(poliza.tipoSeguro);
    final typeIcon = _getTypeIcon(poliza.tipoSeguro);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle: ${poliza.codigo}"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      typeIcon,
                      size: 64,
                      color: typeColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    poliza.cliente,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    poliza.tipoSeguro.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: typeColor,
                    ),
                  ),
                ),
                const Divider(height: 32),
                
                _buildDetailRow(
                  icon: Icons.qr_code,
                  label: "Código de póliza",
                  value: poliza.codigo,
                ),
                const SizedBox(height: 16),
                
                _buildDetailRow(
                  icon: Icons.calendar_today,
                  label: "Fecha de Inicio",
                  value: poliza.fechaInicio,
                ),
                const SizedBox(height: 16),
                
                _buildDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: "Fecha de Vencimiento",
                  value: poliza.fechaVencimiento,
                ),
                const SizedBox(height: 16),
                
                _buildDetailRow(
                  icon: Icons.monetization_on,
                  label: "Valor Asegurado",
                  value: "\$${poliza.valorAsegurado.toStringAsFixed(2)}",
                  valueColor: Colors.deepPurple,
                  valueStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    TextStyle? valueStyle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: valueStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: valueColor ?? Colors.black87,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
