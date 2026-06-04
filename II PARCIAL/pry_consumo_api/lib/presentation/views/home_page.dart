import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  @override
  void initState(){
    super.initState();
    Future.microtask(() => Provider.of<ProductViewModel>(context, listen: false).loadProducts());

  }

  @override
  Widget build(BuildContext context){
  final vm = Provider.of<ProductViewModel>(context);
  // progress circle
  if(vm.loading){
    return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text("Productos"),
    ),
    body: GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,        // 2 columnas
        crossAxisSpacing: 8,      // espacio horizontal entre tarjetas
        mainAxisSpacing: 8,       // espacio vertical entre tarjetas
        childAspectRatio: 0.7,    // relación alto/ancho de cada celda
      ),
      itemCount: vm.products.length,
      itemBuilder: (context, index){
        final p = vm.products[index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/detalle", arguments: p);
          },
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Text(
                    "\$${p.price.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    )
  );
  }
}