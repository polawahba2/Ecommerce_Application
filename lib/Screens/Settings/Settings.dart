import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Components/RoundedButton.dart';
import 'package:shop_app/Components/TextFieldContainer.dart';
import 'package:shop_app/Cubit/LogInCubit/Cubit.dart';
import 'package:shop_app/Cubit/RegisterCubit/States.dart';
import 'package:shop_app/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Cubit/ShopCubit/States.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var updateInfoFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        var myCubit = ShopCubit.getCubit(context);

        return ConditionalBuilder(
          condition: myCubit.userModel != null,
          builder: (context) {
            String name = myCubit.userModel!.data!.name.toString();
            String email = myCubit.userModel!.data!.email.toString();
            String phone = myCubit.userModel!.data!.phone.toString();
            return Container(
              height: size.height,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Form(
                      key: updateInfoFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (state is ShopUpdateProfileLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          const Text(
                            'Update User Info',
                            style: kTextStyle,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                                hintText: '$name',
                                border: InputBorder.none,
                                // helperText: 'name',
                              ),
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'enter valid Name';
                                }
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.mail,
                                  color: kPrimaryColor,
                                ),
                                hintText: '$email',
                                border: InputBorder.none,
                              ),
                              controller: emailController,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains('@')) {
                                  return 'enter valid Email';
                                }
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.phone,
                                  color: kPrimaryColor,
                                ),
                                hintText: '$phone',
                                border: InputBorder.none,
                              ),
                              controller: phoneController,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 7) {
                                  return 'Phone should longer than 6 numbers ';
                                }
                              },
                            ),
                          ),
                          RoundedButton(
                            text: 'Update User Info',
                            color: Colors.purple[800],
                            press: () {
                              if (updateInfoFormKey.currentState!.validate()) {
                                myCubit.UpdateData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                                showToast(
                                    text: 'Data Updated Successfully',
                                    state: ToastStates.SUCESS);
                              }
                            },
                          ),
                          RoundedButton(
                            text: 'Sign Up',
                            color: kPrimaryColor,
                            press: () {
                              signOut(context);
                            },
                          ),
                        ],
                      )),
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
