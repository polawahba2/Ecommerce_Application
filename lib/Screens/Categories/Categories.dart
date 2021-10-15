import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Cubit/ShopCubit/States.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var myCubit = ShopCubit.getCubit(context);
          return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Image(
                          fit: BoxFit.fill,
                          width: size.width * 0.30,
                          height: size.height * 0.14,
                          image: NetworkImage(
                            myCubit.categoriesModel!.data!.data[index].image,
                          )),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        myCubit.categoriesModel!.data!.data[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: myCubit.categoriesModel!.data!.data.length);
        });
  }
}
