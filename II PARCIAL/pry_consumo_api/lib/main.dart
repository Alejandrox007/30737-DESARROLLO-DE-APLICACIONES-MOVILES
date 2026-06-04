import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasource/fakestore_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'presentation/viewmodels/product_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  //inyeccion de dependencias
  final datasource = FakestoreDatasource(); //este objeto se conecta a la API de FakeStore
  final repository = ProductRepositoryImpl(datasource); //usa el datasource para obtener los datos
  final usecase = GetProductsUsecase(repository); //representa la logica de negocio

  runApp( MyApp(usecase:usecase));
}

  class MyApp extends StatelessWidget{
  final GetProductsUsecase usecase;
  const MyApp({super.key, required this.usecase});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel(usecase))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Productos",
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