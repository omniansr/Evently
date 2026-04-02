import 'package:evently/app_theme.dart';
import 'package:evently/onboarding_screen.dart';
import 'package:evently/providers/setting_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartScreen extends StatefulWidget{
  static const String routename = 'start';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String selectedLang ='en';
  String selectedTheme ='light';



  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return SafeArea(
        top:true,
        bottom: true,
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20),
                child: Column(
                  mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .stretch,
                    children: [
                      Center(child: settingProvider.isDark ? Image.asset('assets/images/darkheader.png')
                     : Image.asset('assets/images/header.png')
            ),
                      SizedBox(height: 20,),
                      Image.asset( settingProvider.isDark ?
                      'assets/images/onboardingD1.png'
                        :'assets/images/onboarding1.png',
                        height: 320,
                        fit: BoxFit.contain,
                      ),

                      Text('Personalize Your Experience' , style: Theme.of(context).textTheme.titleLarge,),
                      Text('Choose your preferred theme and\n language to get started '
                          'with a\n comfortable, tailored experience that suits your style.' ,
                        style: Theme.of(context).textTheme.titleMedium,),
                      Row(
                      children: [
                        Text('Language',style: Theme.of(context).textTheme.headlineSmall,),
                        Spacer(),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            selectedLang = 'en';
                          });
                          settingProvider.changeLanguage(selectedLang);

                        },
                            style:ElevatedButton.styleFrom(
                              backgroundColor:
                                 selectedLang =='en'? settingProvider.isDark ? AppTheme.darkPrimary: AppTheme.primary
                                : settingProvider.isDark ? AppTheme.darkblue: AppTheme.white,
                                shape: RoundedRectangleBorder(side:BorderSide(
                                color:  selectedLang !='en'?  settingProvider.isDark  ? AppTheme.lightblue : AppTheme.lightgrey
                                : Colors.transparent)  ,
                                    borderRadius: BorderRadius.circular(8)),
                              elevation: 0
                            ),
                            child: Text('English',style: selectedLang == 'en'?
                            Theme.of(context).textTheme.titleSmall!.copyWith(color: AppTheme.white)
                              : Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: settingProvider.isDark ? AppTheme.white : AppTheme.primary)
                              ,),
                        ),
                        SizedBox(width: 5,),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            selectedLang = 'ar';
                          });
                          settingProvider.changeLanguage(selectedLang);

                        },
                          style:ElevatedButton.styleFrom(
                              backgroundColor:
                              selectedLang =='ar'? settingProvider.isDark ? AppTheme.darkPrimary: AppTheme.primary
                                  : settingProvider.isDark ? AppTheme.darkblue: AppTheme.white,
                              shape: RoundedRectangleBorder(side:BorderSide(
                                  color:  selectedLang !='ar'?  settingProvider.isDark  ? AppTheme.lightblue : AppTheme.lightgrey
                                      : Colors.transparent)  ,borderRadius: BorderRadius.circular(8)),
                            elevation: 0
                          ),
                          child: Text('Arabic',style: selectedLang == 'ar'?
                          Theme.of(context).textTheme.titleSmall!.copyWith(color: AppTheme.white)
                              :   Theme.of(context).textTheme.titleSmall!.copyWith(color:settingProvider.isDark ? AppTheme.white : AppTheme.primary )
                            ,),
                        ),

                      ],
                      ),
                      Row(
                        children: [
                          Text('Theme',style: Theme.of(context).textTheme.headlineSmall,),
                          Spacer(),
                          ElevatedButton(onPressed: (){
                            setState(() {
                              selectedTheme = 'light';
                            });
                            settingProvider.changeTheme(ThemeMode.light);

                          },
                            style:ElevatedButton.styleFrom(
                                backgroundColor:
                                selectedTheme =='light'? settingProvider.isDark? AppTheme.darkPrimary : AppTheme.primary
                                    :settingProvider.isDark ? AppTheme.darkblue : AppTheme.white,
                              shape: RoundedRectangleBorder(side:BorderSide(
                                  color:  selectedTheme !='light'?  settingProvider.isDark  ? AppTheme.lightblue : AppTheme.lightgrey
                                      : Colors.transparent)  ,borderRadius: BorderRadius.circular(8)),

                            ),
                            child: SvgPicture.asset('assets/icons/sun.svg',height: 24,width: 24,
                                colorFilter:
                                ColorFilter.mode(AppTheme.white, BlendMode.srcIn)
                            ),
                          ),
                          SizedBox(width: 5),

                          ElevatedButton(onPressed: (){
                            setState(() {
                              selectedTheme = 'dark';
                            });
                            settingProvider.changeTheme(ThemeMode.dark);

                          },
                              style:ElevatedButton.styleFrom(
                                  backgroundColor:
                                  selectedTheme =='dark'? settingProvider.isDark? AppTheme.darkPrimary : AppTheme.primary
                                      :settingProvider.isDark ? AppTheme.darkblue : AppTheme.white,
                                  shape: RoundedRectangleBorder(side:BorderSide(
                                      color:  selectedTheme !='dark'?  settingProvider.isDark  ? AppTheme.lightblue : AppTheme.lightgrey
                                          : Colors.transparent)  ,borderRadius: BorderRadius.circular(8)),
                              ),
                              child: SvgPicture.asset('assets/icons/moon.svg',height: 24,width: 24,
                                colorFilter: ColorFilter.mode(settingProvider.isDark ? AppTheme.white:
                                    selectedTheme == 'dark'? AppTheme.white : AppTheme.primary , BlendMode.srcIn))
                          ),
          ],
                          ),


                      ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, OnboardingScreen.routename);

                      },style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        backgroundColor: settingProvider.isDark ? AppTheme.darkPrimary:AppTheme.primary,
                        elevation: 0
                      ), child: Text('Let’s start',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppTheme.white),))
                    ],
                ),
            ),
        ),
    );
  }
}
