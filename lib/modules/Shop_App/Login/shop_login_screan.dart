import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gps_tracker/layout/Shop_App/shop_layout.dart';
import 'package:gps_tracker/modules/Shop_App/Login/cubit/Cubit.dart';
import 'package:gps_tracker/modules/Shop_App/Login/cubit/States.dart';
import 'package:gps_tracker/modules/Shop_App/Register/Shop_Register_Screan.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/components/constens.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';

class ShopLoginScrean extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSucseslState){
            if(state.loginmodel.stutes){
              print(state.loginmodel.message);
              print(state.loginmodel.data?.token);
            casheHelper.SavaData(key: 'token', value: state.loginmodel.data?.token).then((value) {
              token = state.loginmodel.data?.token??'${state.loginmodel.data?.token}';
              navigateToAndFinish(context, Shop_Layout());
            });
            }else {
              showToast(
                  text: state.loginmodel.message!,
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login'.toUpperCase() ,
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'login now to browse our hot offers' ,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 30,),
                        defultFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email_outlined,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Email must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15,),
                        defultFormField(
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            label: 'Password',
                            suffix:ShopLoginCubit.get(context).suffix,
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            onSubmeted: (value){
                              if(formkey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              }},

                            passwordShow: (){
                              ShopLoginCubit.get(context).ChangePasswordVisibilty();
                            },
                            prefix: Icons.lock_outline,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Password must not be empty';
                              }
                            }),
                        SizedBox(height: 30,),
                        BuildCondition(
                          condition: state is! ShopLoginLodingState,
                          builder: (context) => defultButton(
                            text: 'login',
                            isUpperCase: true,
                            function: (){
                              print( emailController.text);
                              print( passwordController.text);
                              if(formkey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );


                              }
                            },

                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont\'t have an account?'),
                            defultTextButtton(text: 'register now', function: (){
                              navigateTo(context, ShopRegisterScrean());
                            }),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
