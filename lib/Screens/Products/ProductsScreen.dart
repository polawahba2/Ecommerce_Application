import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Cubit/ShopCubit/States.dart';

class ProductsScreen extends StatelessWidget {
  // get options => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // print(ShopCubit.getCubit(context).favorites);
        var size = MediaQuery.of(context).size;
        var myCubit = ShopCubit.getCubit(context);
        return BuildCondition(
          condition:
              myCubit.homeModel != null && myCubit.categoriesModel != null,
          builder: (context) {
            // print(myCubit.homeModel!.data.banners);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: myCubit.homeModel!.data.banners
                        .map((e) => Image(
                              image: NetworkImage('${e['image']}'),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      height: 200,
                      // initialPage: 0,
                      enableInfiniteScroll: true,
                      // reverse: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      scrollDirection: Axis.horizontal,
                      pauseAutoPlayInFiniteScroll: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 15, 9, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          height: 100,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    Image(
                                      image: NetworkImage(myCubit
                                          .categoriesModel!
                                          .data!
                                          .data[index]
                                          .image),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      color: Colors.black.withOpacity(0.8),
                                      child: Text(
                                        myCubit.categoriesModel!.data!
                                            .data[index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              itemCount:
                                  myCubit.categoriesModel!.data!.data.length),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Text(
                          'New Products',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 1.7,
                        children: List.generate(
                          myCubit.homeModel!.data.products.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      myCubit.homeModel!.data.products[index]
                                          ['image'],
                                    ),
                                    width: double.infinity,
                                    // fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                  if (myCubit.homeModel!.data.products[index]
                                          ['discount'] !=
                                      0)
                                    Container(
                                      color: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.0),
                                      child: Text(
                                        '${myCubit.homeModel!.data.products[index]['discount']}%',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myCubit.homeModel!.data.products[index]
                                          ['name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        height: 1.3,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${myCubit.homeModel!.data.products[index]['price'].round()}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        if (myCubit.homeModel!.data
                                                .products[index]['discount'] !=
                                            0)
                                          Text(
                                            '${myCubit.homeModel!.data.products[index]['old_price'].round()}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        const Spacer(),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: (myCubit.favorites[
                                                      myCubit.homeModel!.data
                                                              .products[index]
                                                          ['id']] ??
                                                  true)
                                              ? Colors.red
                                              : Colors.grey,
                                          child: IconButton(
                                            onPressed: () {
                                              myCubit.ChangeFavorites(myCubit
                                                  .homeModel!
                                                  .data
                                                  .products[index]['id']);
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
                        )),
                  ),
                ],
              ),
            );
          },
          //
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// Widget productsBuilder(HomeModel model) {
//   return Column();
// }
// ConditionalBuilder(
//             condition: (myCubit.homeModel != null),
//             builder: (context) => productsBuilder(),
//             fallback: (context) => Center(
//               child: CircularProgressIndicator(),
//             ),
//           );

// myCubit.homeModel!.data.banners.map((e) => null).toList(),

    