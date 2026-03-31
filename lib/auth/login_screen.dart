import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui_utils.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  static const String routename = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = .new();
  TextEditingController password = .new();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsetsDirectional.only(top: 50,start: 16,end: 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Center(child: Image.asset(isDark? 'assets/images/darkheader.png':'assets/images/header.png', height: 27,)),
              SizedBox(height: 48),
              Text('Login to your account',style: textTheme.headlineMedium,
                textAlign: .right,),
              SizedBox(height: 28),
              DefaultTextFormField( type: DefaultTextFormFieldType.auth,
                hintText: 'Enter your email',
                prifixIconImageName: 'email',
                controller: email,
                validator: (value){
                  if(value == null || value.length<2){
                    return 'Invalid email';
                  }
                  return null;
                },),
              SizedBox(height: 16),

              DefaultTextFormField(
                type: DefaultTextFormFieldType.auth,
                hintText: 'Enter your password',
                prifixIconImageName: 'password',
                controller: password,
                validator: (value){
                  if(value == null || value.length<2){
                    return 'Invalid password';
                  }
                  return null;
                },
                isPassword: true,),
              SizedBox(height: 48),
              DefaultElevatedButton(label: 'Login', onPressed: (){
                login();
              }),
              SizedBox(height: 32,),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text('Don’t have an account ?',style: textTheme.titleSmall?.copyWith(color: isDark?
                  AppTheme.lightoffwhite : AppTheme.gray),),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushReplacementNamed(RegisterScreen.routename);
                  }, child: Text('Sign up'))
                ],
              ),
              SizedBox(height: 32,),
              Row(
                children: [
                  Expanded(child: Divider(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey,)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text('Or',style:  textTheme.titleMedium!.copyWith(color: isDark? AppTheme.darkPrimary: AppTheme.primary
                        ,fontWeight: .w500)
                    ),
                  ),
                  Expanded(child: Divider(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey,)),
                ],
              ),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppTheme.darkBlack : AppTheme.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: .circular(16),
                        side: BorderSide(color: isDark? AppTheme.lightblue : AppTheme.lightgrey))
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset('assets/images/google.png'),
                    SizedBox(width: 16,),
                    Text('Login with Google',style: textTheme.headlineSmall,)
                  ],
                ),)


            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if(formKey.currentState!.validate()) {
      try {
        UserModel user = await FirebaseService.login(
            email: email.text, password: password.text);
        Provider.of<UserProvider>(context, listen: false).updateCurrentUser(
            user);
        Provider.of<EventProvider>(context, listen: false).clearEvents();
        await Provider.of<EventProvider>(context, listen: false).getEvents();
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      }catch (error){
        String? errorMessage;
        if(error is FirebaseAuthException)
        {
          errorMessage = error.message;
        }
        UiUtils.showErrorMessage(errorMessage);
      }
    }
  }
}