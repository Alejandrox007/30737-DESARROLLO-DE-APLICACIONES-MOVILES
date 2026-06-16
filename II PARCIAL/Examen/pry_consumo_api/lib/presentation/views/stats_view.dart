import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/poliza_viewmodel.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);

    final totalPolizas = vm.polizas.length;
    final totalValorAsegurado = vm.polizas.fold(0.0, (sum, item) => sum + item.valorAsegurado);
    final promedioValor = totalPolizas == 0 ? 0.0 : totalValorAsegurado / totalPolizas;

    // Conteo por tipos
    final Map<String, int> conteoTipos = {};
    for (var p in vm.polizas) {
      conteoTipos[p.tipoSeguro] = (conteoTipos[p.tipoSeguro] ?? 0) + 1;
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => vm.loadPolizas(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Resumen Estadístico",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Tarjetas principales
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: "Total Pólizas",
                      value: totalPolizas.toString(),
                      icon: Icons.assignment_outlined,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: "Valor Asegurado",
                      value: "\$${totalValorAsegurado.toStringAsFixed(2)}",
                      icon: Icons.monetization_on_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                title: "Promedio por Póliza",
                value: "\$${promedioValor.toStringAsFixed(2)}",
                icon: Icons.trending_up,
                color: Colors.blue,
              ),
              
              const SizedBox(height: 24),
              const Text(
                "Distribución por Tipo de Seguro",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              if (totalPolizas == 0)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "No hay datos suficientes para mostrar estadísticas.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                ...conteoTipos.entries.map((entry) {
                  final porcentaje = (entry.value / totalPolizas) * 100;
                  return _buildTypeDistributionItem(
                    type: entry.key,
                    count: entry.value,
                    percentage: porcentaje,
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: color, size: 24),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeDistributionItem({
    required String type,
    required int count,
    required double percentage,
  }) {
    Color color;
    switch (type.toLowerCase()) {
      case 'vida':
        color = Colors.green;
        break;
      case 'auto':
        color = Colors.blue;
        break;
      case 'salud':
        color = Colors.orange;
        break;
      case 'hogar':
        color = Colors.purple;
        break;
      default:
        color = Colors.teal;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      type,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$count ($percentage%)",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
