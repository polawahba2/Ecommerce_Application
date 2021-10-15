import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper.dart';
import 'package:shop_app/Screens/HomePage.dart';
import 'package:shop_app/Screens/OnBoardingScreen.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/Shared/CasheHelper.dart';

import 'Components/Constants.dart';
import 'Cubit/LogInCubit/BlocObserver.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initialize();
  await CashHelper.init();

  bool onBoarding = CashHelper.getDate(key: 'onBoarding') ?? false;
  token = CashHelper.getDate(key: 'token') ?? '';

  Widget? startWidget;

  if (onBoarding != false) {
    if (token == '') {
      startWidget = LogInScreen();
    } else {
      startWidget = HomePage();
    }
  } else {
    startWidget = OnBoardingScreen();
  }
  print('the token is  $token');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
    ),
  );
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     return BlocProvider(create: (BuildContext context) => ShopCubit());
//   }
// }
