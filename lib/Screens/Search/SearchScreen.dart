import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Components/TextFieldContainer.dart';
import 'package:shop_app/Cubit/SearchCubit/Cubit.dart';
import 'package:shop_app/Cubit/SearchCubit/States.dart';
import 'package:shop_app/Cubit/ShopCubit/ShopCubit.dart';

class SearchScreen extends StatelessWidget {
  var searchFormKey = GlobalKey<FormState>();
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var size = MediaQuery.of(context).size;
            var myCubit = ShopSearchCubit.getCubit(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height,
                  child: Form(
                    key: searchFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFieldContainer(
                          color: Colors.grey[200],
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.search_rounded,
                                color: kPrimaryColor,
                              ),
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                            controller: searchTextController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter valid ';
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (searchFormKey.currentState!.validate()) {
                                ShopSearchCubit.getCubit(context).search(value);
                              }
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: size.height * 0.2,
                        // ),
                        if (state is ShopSearchLoadingState)
                          const CircularProgressIndicator(),
                        if (state is ShopSearchSuccessState)
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: size.width,
                                    // height: size.height,
                                    child: Row(
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            '${myCubit.searchModel!.data!.data[index]['image']}',
                                          ),
                                          fit: BoxFit.contain,
                                          width: size.width * 0.33,
                                          height: size.height * 0.15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${myCubit.searchModel!.data!.data[index]['name']}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              // const Spacer(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      '${myCubit.searchModel!.data!.data[index]['price']}'),
                                                  SizedBox(
                                                    width: size.width * 0.01,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(),
                                itemCount:
                                    myCubit.searchModel!.data!.data.length),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
