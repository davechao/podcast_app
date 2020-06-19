import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/login/login_bloc.dart';
import 'package:podcastapp/model/config.dart';
import 'package:podcastapp/model/config_provider.dart';
import 'package:podcastapp/model/repository/account_repository.dart';
import 'package:podcastapp/page/login/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Config _config = ConfigProvider.of(context).config;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => LoginBloc(
            repository: AccountRepository(
              _config.apiBaseUrl,
            ),
          ),
          child: LoginPage(),
        )

//      home: BlocProvider(
//        create: (context) => PodCastBloc(
//          repository: PodCastRepository(
//            client: _config.graphQLClient,
//          ),
//        ),
//        child: PodCastsPage(),
//      ),

        );
  }
}
