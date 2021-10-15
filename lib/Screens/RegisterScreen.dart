import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/BackGround.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Components/RoundedButton.dart';
import 'package:shop_app/Components/TextFieldContainer.dart';
import 'package:shop_app/Cubit/RegisterCubit/Cubit.dart';
import 'package:shop_app/Cubit/RegisterCubit/States.dart';
import 'package:shop_app/Screens/HomePage.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/Shared/CasheHelper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.RegisterModel.status) {
            showToast(
                text: state.RegisterModel.message.toString(),
                state: ToastStates.SUCESS);
            CashHelper.saveData(
                    key: 'token', value: state.RegisterModel.data!.token)
                .then((value) {
              token = state.RegisterModel.data!.token.toString();
              pushAndTerminate(context: context, route: HomePage());
            });
            // showToast(
            //     text: '${state.logInModel.message}', state: ToastStates.SUCESS);
          } else {
            print(state.RegisterModel.message);
            showToast(
                text: '${state.RegisterModel.message}',
                state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        var myCubit = ShopRegisterCubit.getCubit(context);
        var size = MediaQuery.of(context).size;

        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Sign Up'),
          // ),
          body: BackGround(
            child: Center(
                child: Form(
              key: registerFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Register',
                      style: kTextStyle,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFieldContainer(
                    
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          ),
                          hintText: 'Name',
                          border: InputBorder.none,
                        ),
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter valid Email';
                          }
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          ),
                          hintText: 'enter your e-mail',
                          border: InputBorder.none,
                        ),
                        controller: eMailController,
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
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          hintText: 'enter your password',
                          border: InputBorder.none,
                        ),
                        controller: passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5) {
                            return 'enter valid password';
                          }
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          hintText: 're enter your password',
                          border: InputBorder.none,
                        ),
                        controller: rePasswordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              passwordController.text !=
                                  rePasswordController.text) {
                            return 'the password is not identical';
                          }
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          hintText: 'enter your number',
                          border: InputBorder.none,
                        ),
                        controller: phoneController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10) {
                            return 'enter valid number';
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (registerFormKey.currentState!.validate()) {
                            myCubit.userRegister(
                              name: name.text,
                              email: eMailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                    ),
                    BuildCondition(
                      condition: state is! ShopRegisterLoadingState,
                      builder: (context) => RoundedButton(
                        text: 'Sign Up',
                        color: kPrimaryColor,
                        press: () {
                          if (registerFormKey.currentState!.validate()) {
                            myCubit.userRegister(
                              name: name.text,
                              email: eMailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('if you  have an account click  '),
                        InkWell(
                          child: const Text(
                            'here ',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            pushAndTerminate(
                                context: context, route: LogInScreen());
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
          ),
        );
      }),
    );
  }
}
