import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miniprojet/modules/shop_app/login/cubit/cubit.dart';
import 'package:miniprojet/modules/shop_app/login/cubit/states.dart';
import 'package:miniprojet/modules/shop_app/register/shop_register_screen.dart';

class ShopLoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ShopLoginScreen> {
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if(state is ShopLoginSuccessState){
              if(state.loginModel.status){
                print(state.loginModel.message);
                Fluttertoast.showToast(
                    msg: state.loginModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.lightGreen,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
              else{
                print(state.loginModel.message);
                Fluttertoast.showToast(
                    msg: state.loginModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                        child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.0,
                                ),
                                Image.asset('assets/images/shop_image.png',
                                  width: 315,
                                  height: 315,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    prefixIcon: Icon(
                                      Icons.email,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field must not be empty.';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: ShopLoginCubit.get(context).isPassword,
                                  onFieldSubmitted: (value) {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        ShopLoginCubit.get(context).changePasswordVisibility();
                                      },
                                      icon: Icon(
                                        ShopLoginCubit.get(context).suffix,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field must not be empty.';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                ConditionalBuilder(
                                    condition: state is! ShopLoginLoadingState,
                                    builder: (context) => Container(
                                          width: double.infinity,
                                          color: Colors.blue,
                                          child: MaterialButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                ShopLoginCubit.get(context)
                                                    .userLogin(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                );
                                              }
                                            },
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: Colors.white,
                                              fontSize: 17),
                                            ),
                                          ),
                                        ),
                                    fallback: (context) => Center(
                                        child: CircularProgressIndicator())),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShopRegisterScreen()),
                                          );
                                        },
                                        child: Text(
                                            'Register Now.',
                                          style: TextStyle(fontSize: 16),
                                        ))
                                  ],
                                ),
                              ],
                            )))));
          },
        ));
  }
}
