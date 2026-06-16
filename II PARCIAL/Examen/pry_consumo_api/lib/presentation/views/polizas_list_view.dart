import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/poliza_viewmodel.dart';
import '../../domain/entities/poliza.dart';

class PolizasListView extends StatefulWidget {
  const PolizasListView({super.key});

  @override
  State<PolizasListView> createState() => _PolizasListViewState();
}

class _PolizasListViewState extends State<PolizasListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PolizaViewModel>(context, listen: false).loadPolizas());
  }

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
    final vm = Provider.of<PolizaViewModel>(context);

    if (vm.loading && vm.polizas.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null && vm.polizas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              vm.errorMessage!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => vm.loadPolizas(),
              child: const Text("Reintentar"),
            )
          ],
        ),
      );
    }

    if (vm.polizas.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No hay pólizas registradas",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => vm.loadPolizas(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: vm.polizas.length,
        itemBuilder: (context, index) {
          final poliza = vm.polizas[index];
          final typeColor = _getTypeColor(poliza.tipoSeguro);
          final typeIcon = _getTypeIcon(poliza.tipoSeguro);

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(context, "/detalle", arguments: poliza);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: typeColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: typeColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              Icon(typeIcon, size: 16, color: typeColor),
                              const SizedBox(width: 6),
                              Text(
                                poliza.tipoSeguro,
                                style: TextStyle(
                                    color: typeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          poliza.codigo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple.shade50,
                          child: Icon(Icons.person,
                              color: Colors.deepPurple.shade700),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                poliza.cliente,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Vence: ${poliza.fechaVencimiento}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Valor Asegurado",
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            Text(
                              "\$${poliza.valorAsegurado.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Inicio: ${poliza.fechaInicio}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.pushNamed(context, "/editar",
                                    arguments: poliza);
                              },
                              tooltip: "Editar",
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmDelete(context, poliza),
                              tooltip: "Eliminar",
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, Poliza poliza) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirmar Eliminación"),
          content: Text(
              "¿Está seguro de que desea eliminar la póliza ${poliza.codigo} de ${poliza.cliente}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                final vm = Provider.of<PolizaViewModel>(context, listen: false);
                final success = await vm.deletePoliza(poliza.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? "Póliza eliminada con éxito"
                          : "Error al eliminar póliza"),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
