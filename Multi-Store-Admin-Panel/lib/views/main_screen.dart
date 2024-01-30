import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_store_web/views/side_views/categories_screen.dart';
import 'package:multi_store_web/views/side_views/dashboad_screen.dart';
import 'package:multi_store_web/views/side_views/orders_screen.dart';
import 'package:multi_store_web/views/side_views/products_screen.dart';
import 'package:multi_store_web/views/side_views/uploadbanner_screen.dart';
import 'package:multi_store_web/views/side_views/vendors_screen.dart';
import 'package:multi_store_web/views/side_views/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectScreen = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.screenRoute:
        setState(() {
          _selectScreen = DashboardScreen();
        });
        break;
      case VendorsScreen.screenRoute:
        setState(() {
          _selectScreen = VendorsScreen();
        });
        break;
      case UploadBannerScreen.screenRoute:
        setState(() {
          _selectScreen = UploadBannerScreen();
        });
        break;
      case OrderScreen.screenRoute:
        setState(() {
          _selectScreen = OrderScreen();
        });
        break;
      case ProductsScreen.screenRoute:
        setState(() {
          _selectScreen = ProductsScreen();
        });
        break;
      case CategoriesScreen.screenRoute:
        setState(() {
          _selectScreen = CategoriesScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('MultiStore'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendor',
            route: VendorsScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            route: WithdrawalScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoriesScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Products',
            route: ProductsScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            route: UploadBannerScreen.screenRoute,
            icon: Icons.dashboard,
          ),

        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Admin Banner',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Made by Evans Jimenez',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectScreen,
    );
  }
}
