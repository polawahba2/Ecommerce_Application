import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Components/BackGround.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Components/RoundedButton.dart';
import 'package:shop_app/Components/TextFieldContainer.dart';
import 'package:shop_app/Cubit/LogInCubit/Cubit.dart';
import 'package:shop_app/Cubit/LogInCubit/States.dart';
import 'package:shop_app/Screens/RegisterScreen.dart';

import 'package:shop_app/Shared/CasheHelper.dart';

import 'HomePage.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var logInFormKey = GlobalKey<FormState>();
  // var currentUserEmail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLogInCubit(),
      child: BlocConsumer<ShopLogInCubit, ShopLogInStates>(
          listener: (context, state) {
        if (state is ShopLogInSuccessState) {
          if (state.logInModel.status) {
            showToast(
                text: state.logInModel.message.toString(),
                state: ToastStates.SUCESS);
            CashHelper.saveData(
                    key: 'token', value: state.logInModel.data!.token)
                .then((value) {
              token = state.logInModel.data!.token.toString();
              pushAndTerminate(context: context, route: HomePage());
            });
            // showToast(
            //     text: '${state.logInModel.message}', state: ToastStates.SUCESS);
          } else {
            print(state.logInModel.message);
            showToast(
                text: '${state.logInModel.message}', state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        var size = MediaQuery.of(context).size;
        // var myCubit = ShopLogInCubit.getCubit(context);
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Log In'),
          // ),
          body: BackGround(
            child: SingleChildScrollView(
              child: Form(
                key: logInFormKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, size.height * 0.15, 0, 0),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'LogIn',
                        style: kTextStyle,
                      ),
                      SizedBox(height: size.height * 0.12),
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
                                value.length < 6) {
                              return 'enter valid password';
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (logInFormKey.currentState!.validate()) {
                              ShopLogInCubit.getCubit(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                      ),
                      BuildCondition(
                        condition: state is! ShopLogInLoadingState,
                        builder: (context) => RoundedButton(
                          text: 'Log In ',
                          color: kPrimaryColor,
                          press: () {
                            if (logInFormKey.currentState!.validate()) {
                              ShopLogInCubit.getCubit(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) =>
                            const CircularProgressIndicator(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('don\'t have an account  '),
                          InkWell(
                            child: const Text(
                              'here ',
                              style: TextStyle(
                                fontSize: 17,
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              pushAndTerminate(
                                  context: context, route: RegisterScreen());
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
