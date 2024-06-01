import 'package:flutter/material.dart';
import 'package:iot_control/view/employee/deliveries_page.dart';
import 'package:iot_control/view/employee/operators_page.dart';
import 'package:iot_control/view/employee/trucks_page.dart';

import '../../controller/login/logout_controller.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  late int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: [
          const Text('Pedidos en viaje'),
          const Text('Registro de camiones'),
          const Text('Registro de operadores'),
        ][currentIndex],
        actions: const [
          LogoutController()
        ],
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: <Widget> [
        const DeliveriesPage(),
        const TrucksPage(),
        const OperatorsPage(),
      ][currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.delivery_dining_outlined),
            selectedIcon: Icon(Icons.delivery_dining_rounded, color: Colors.white),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Icon(Icons.car_repair_outlined),
            selectedIcon: Icon(Icons.car_repair, color: Colors.white),
            label: 'Camiones',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_pin_outlined),
            selectedIcon: Icon(Icons.person_pin_rounded, color: Colors.white),
            label: 'Operadores',
          ),
        ]
      ),
      floatingActionButton: [
        null,null,null
      ][currentIndex],
    );
  }
}
