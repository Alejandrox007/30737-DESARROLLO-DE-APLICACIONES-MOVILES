import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasource/poliza_api_datasource.dart';
import 'data/repositories/poliza_repository_impl.dart';
import 'domain/usecases/get_polizas_usecase.dart';
import 'domain/usecases/create_poliza_usecase.dart';
import 'domain/usecases/update_poliza_usecase.dart';
import 'domain/usecases/delete_poliza_usecase.dart';
import 'presentation/viewmodels/poliza_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  // Asegurar inicialización de bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Inyección de dependencias
  final datasource = PolizaApiDatasource();
  final repository = PolizaRepositoryImpl(datasource);
  
  final getUsecase = GetPolizasUsecase(repository);
  final createUsecase = CreatePolizaUsecase(repository);
  final updateUsecase = UpdatePolizaUsecase(repository);
  final deleteUsecase = DeletePolizaUsecase(repository);

  runApp(MyApp(
    getUsecase: getUsecase,
    createUsecase: createUsecase,
    updateUsecase: updateUsecase,
    deleteUsecase: deleteUsecase,
  ));
}

class MyApp extends StatelessWidget {
  final GetPolizasUsecase getUsecase;
  final CreatePolizaUsecase createUsecase;
  final UpdatePolizaUsecase updateUsecase;
  final DeletePolizaUsecase deleteUsecase;

  const MyApp({
    super.key,
    required this.getUsecase,
    required this.createUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  });
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PolizaViewModel(
            getPolizasUsecase: getUsecase,
            createPolizaUsecase: createUsecase,
            updatePolizaUsecase: updateUsecase,
            deletePolizaUsecase: deleteUsecase,
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Pólizas de Seguro",
        initialRoute: "/",
        routes: AppRoutes.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}