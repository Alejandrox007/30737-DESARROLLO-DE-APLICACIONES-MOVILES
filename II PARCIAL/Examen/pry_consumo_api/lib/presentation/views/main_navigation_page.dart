import 'package:flutter/material.dart';
import 'polizas_list_view.dart';
import 'poliza_form_view.dart';
import 'stats_view.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PolizasListView(),
      PolizaFormView(
        onSubmitSuccess: () {
          // Cambiar a la pestaña de listado al registrar exitosamente
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
      const StatsView(),
    ];
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return "Pólizas de Seguro";
      case 1:
        return "Nueva Póliza";
      case 2:
        return "Estadísticas";
      default:
        return "Pólizas";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Listado",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Registrar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Estadísticas",
          ),
        ],
      ),
    );
  }
}
