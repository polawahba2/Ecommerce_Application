import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Cubit/ShopCubit/States.dart';
import 'package:shop_app/Screens/Search/SearchScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var myCubit = ShopCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  color: Colors.black,
                  onPressed: () {
                    pushOnly(context: context, route: SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                )
              ],
              title: const Text(
                'Welcome',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: myCubit.bottomScreens[myCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: myCubit.currentIndex,
              onTap: (index) {
                myCubit.changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
