import 'package:admin_dashboard/ui/widgets/costos_table.dart';
import 'package:admin_dashboard/ui/widgets/invetario_table.dart';
import 'package:admin_dashboard/ui/widgets/rentabilidad_table.dart'
;
import 'package:flutter/material.dart';

class OperativoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de pestañas (Usuarios y Permisos)
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white, // Fondo blanco
                  child: const Center(
                    child: Text('Insumos', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: Colors.white, // Fondo blanco
                  child: const Center(
                    child: Text('Costo', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: Colors.white, // Fondo blanco
                  child: const Center(
                    child: Text('Rentabilidad', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: const Color.fromARGB(183, 198, 199, 157)
                        .withOpacity(0.9),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child:  Center(
                      child: InventarioView()
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: const Color.fromARGB(183, 198, 199, 157)
                        .withOpacity(0.9),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: CostosView(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: const Color.fromARGB(183, 198, 199, 157)
                        .withOpacity(0.9),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: RentabilidadView(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
