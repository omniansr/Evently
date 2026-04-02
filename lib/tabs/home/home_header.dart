import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader  extends StatefulWidget{
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,top: 16,right: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Welcome Back ✨',style: isDark?
              textTheme.titleSmall!.copyWith(color: AppTheme.lightoffwhite,fontWeight: FontWeight.w400)
              :textTheme.titleSmall!.copyWith(color: AppTheme.gray,fontWeight: FontWeight.w400)),
          Text(currentUser.name,style: isDark?
          textTheme.titleLarge!.copyWith(color: AppTheme.white,fontWeight: FontWeight.w500)
          :textTheme.titleLarge!.copyWith(color: AppTheme.black,fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: DefaultTabController(
              length: CategoryModel.categories.length+1,
              child: TabBar(
                isScrollable: true,
                tabAlignment: .start,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.only(right: 8),
                tabs: [
                  TabItem(name: 'All',
                      isSelected: currentIndex == 0 ,
                      icon: Icons.category_outlined ),
                  ...CategoryModel.categories.map((category) =>
                      TabItem(name: category.name,
                        isSelected: currentIndex == CategoryModel.categories.indexOf(category) +1,
                        icon: category.icon,
                        iconPath: category.iconPath,)
                  ).toList(),
                ],
                onTap: (index){
                  if(currentIndex == index) return;
                  currentIndex = index;
                  CategoryModel? selectedCategory = index == 0 ? null
                  :CategoryModel.categories[index - 1];
                  Provider.of<EventProvider>(context,listen: false).filterEvents(selectedCategory);
                  setState(() {});

                },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}