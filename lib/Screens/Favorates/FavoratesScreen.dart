import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Cubit/ShopCubit/States.dart';

// myCubit.getFavoritesModel!.data!.data[index]
//     ['product']['image'],

class FavoratesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var myCubit = ShopCubit.getCubit(context);
          // print(ShopCubit.getCubit(context).favorites);
          // print(ShopCubit.getCubit(context).favorites.length);
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(12, 15, 12, 10),
                    child: SizedBox(
                      width: size.width,
                      // height: size.height,
                      child: Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Image(
                                image: NetworkImage(
                                  '${myCubit.getFavoritesModel!.data!.data[index]['product']['image']}',
                                ),
                                fit: BoxFit.contain,
                                width: size.width * 0.33,
                                height: size.height * 0.15,
                              ),
                              if (myCubit.getFavoritesModel!.data!.data[index]
                                      ['product']['discount'] !=
                                  0)
                                Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Text(
                                    '${myCubit.getFavoritesModel!.data!.data[index]['product']['discount']}%',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${myCubit.getFavoritesModel!.data!.data[index]['product']['name']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // const Spacer(),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        '${myCubit.getFavoritesModel!.data!.data[index]['product']['price']}'),
                                    // SizedBox(
                                    //   width: size.width * 0.01,
                                    // ),
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: (myCubit.favorites[
                                                  myCubit.getFavoritesModel!
                                                          .data!.data[index]
                                                      ['product']['id']] ??
                                              true)
                                          ? Colors.red
                                          : Colors.grey,
                                      child: IconButton(
                                        onPressed: () {
                                          myCubit.ChangeFavorites(myCubit
                                              .getFavoritesModel!
                                              .data!
                                              .data[index]['product']['id']);
                                        },
                                        icon: Icon(
                                          Icons.favorite_border,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(),
                itemCount: myCubit.getFavoritesModel!.data!.data.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
