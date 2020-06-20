import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/animation/animation_bloc.dart';
import 'package:podcastapp/bloc/login/login_bloc.dart';
import 'package:podcastapp/bloc/login/login_event.dart';
import 'package:podcastapp/bloc/login/login_state.dart';
import 'package:podcastapp/bloc/podcasts/podcast_bloc.dart';
import 'package:podcastapp/model/config.dart';
import 'package:podcastapp/model/config_provider.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';
import 'package:podcastapp/model/repository/vo/login_request.dart';
import 'package:podcastapp/page/podcasts/podcasts_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;
  AnimationBloc animationBloc;

  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  void _navigateToHomeScreen() {
    Config _config = ConfigProvider.of(context).config;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => PodCastBloc(
            repository: PodCastRepository(
              client: _config.graphQLClient,
            ),
          ),
          child: PodCastsPage(),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 1.0],
          colors: [
            Color.fromRGBO(170, 207, 211, 1.0),
            Color.fromRGBO(93, 142, 155, 1.0),
          ],
        ),
      ),
    );
  }

  Widget _buildGuss() {
    return BlocBuilder<AnimationBloc, String>(builder: (context, state) {
      return Container(
        height: 200,
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        child: FlareActor(
          "assets/Guss.flr",
          shouldClip: false,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          animation: state,
        ),
      );
    });
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildAccountTextFormField(),
          _buildPasswordTextFormField(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildAccountTextFormField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Account",
          hintText: "Please enter your account",
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your account";
          } else {
            return null;
          }
        },
        controller: _accountController,
      ),
    );
  }

  Widget _buildPasswordTextFormField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Please enter your password",
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your password";
          } else {
            return null;
          }
        },
        controller: _passwordController,
        focusNode: _passwordFocusNode,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(160, 92, 147, 1.0),
            Color.fromRGBO(115, 82, 135, 1.0)
          ],
        ),
      ),
      child: InkWell(
        child: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              fontFamily: "RobotoMedium",
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          if (_formKey.currentState.validate()) {
            final account = _accountController.text.toString();
            final password = _passwordController.text.toString();
            final request = LoginRequest("app.internal", account, password);
            loginBloc.add(Login(request));
          }
        },
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        animationBloc.add(AnimationEvent.cover_eyes_in);
      } else {
        if (animationBloc.isCoverEyesIn()) {
          animationBloc.add(AnimationEvent.cover_eyes_out);
        }
      }
    });
    loginBloc = BlocProvider.of<LoginBloc>(context);
    animationBloc = BlocProvider.of<AnimationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is Success) {
            _navigateToHomeScreen();
          } else if (state is Error) {
            animationBloc.add(AnimationEvent.fail);
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (animationBloc.isCoverEyesIn()) {
              animationBloc.add(AnimationEvent.cover_eyes_out);
            } else {
              animationBloc.add(AnimationEvent.idle);
            }
          },
          child: Stack(
            children: <Widget>[
              _buildBackground(),
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: devicePadding.top + 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildGuss(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: _buildForm(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
