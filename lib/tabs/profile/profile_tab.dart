import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/language_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/setting_Provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 32,),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/route_logo.png'),
            radius: 58,
          ),
          SizedBox(height: 16,),
          Text(currentUser.name , style: textTheme.titleLarge!.copyWith(color: isDark? AppTheme.white:
          AppTheme.black,),),
          SizedBox(height: 4,),
          Text(currentUser.email,style: textTheme.titleSmall!.copyWith(fontWeight: .w400,
              color: AppTheme.gray ),),
          SizedBox(height: 32,),
          Container(
            decoration: BoxDecoration(
              borderRadius: .circular(16),
                border: BoxBorder.all(
                    color: isDark? AppTheme.lightblue : AppTheme.lightgrey
                )
            ),
            child: SwitchListTile(
                value: settingProvider.isDark,
              onChanged: (isDark){
                  settingProvider.changeTheme(isDark ? .dark : .light);
              },
                title: Text('Dark Mode'),
              activeTrackColor: primaryColor,
              inactiveTrackColor: AppTheme.brightgrey,
              thumbColor: WidgetStatePropertyAll(AppTheme.white),
              trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
              contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
            ),
          ),
          SizedBox(height: 16,),
          Container(
            decoration: BoxDecoration(
                borderRadius: .circular(16),
                border: BoxBorder.all(
                    color: isDark? AppTheme.lightblue : AppTheme.lightgrey
                )
            ),
            child: ListTile(
              title: Text('Language'),
              trailing: DropdownButton(
                value: 'en',
                items: LanguageModel.languages
                      .map((language) => DropdownMenuItem(
                    value: language.code,
                    child: Text(language.name)
                )
                ).toList(),
              onChanged: (value){},
              dropdownColor: isDark? AppTheme.darkblue : AppTheme.white, 
                underline: SizedBox(),
                borderRadius: .circular(16),
              ),
            ),
          ),
          SizedBox(height: 16,),
          Container(
            decoration: BoxDecoration(
              borderRadius: .circular(16),
              border: BoxBorder.all(
                color: isDark? AppTheme.lightblue : AppTheme.lightgrey
              )
            ),
            child: ListTile(
              title: Text('Logout'),
              trailing: SvgPicture.asset('assets/icons/logout.svg',height: 24,
              width: 24,fit: .fill,),
              onTap: () => FirebaseService.logout().then((_){
                Provider.of<EventProvider>(context, listen: false).clearEvents();
                Navigator.of(context).pushReplacementNamed(LoginScreen.routename).
                    then((_){
                      Provider.of<UserProvider>(context).updateCurrentUser(null);
                });
              }),
            ),

          ),

        ],
      ),
    );
  }
}