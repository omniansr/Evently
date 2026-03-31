import 'package:evently/app_theme.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/app_bar_actions.dart';
import 'package:evently/widgets/arrow_back.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget{
  static const String routename = 'details';


  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  CategoryModel selectedCategory = CategoryModel.categories.first;
  int currentIndex = 0 ;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  @override
  Widget build(BuildContext context) {

    Color primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Size screenSize = MediaQuery.sizeOf(context);
 final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: ArrowBack() , title: Text('Event details'),
        actions: [
        InkWell(child: AppBarActions(svgName: 'edit', isEdit: true),onTap: (){
          Navigator.of(context).pushReplacementNamed(CreateEventScreen.routename,arguments: event);
        },),
        Padding(
          padding: const EdgeInsets.only(right: 16.0,left: 8),
          child: InkWell(child: AppBarActions(svgName: 'delete', isEdit: false),
            onTap: (){
            FirebaseService.deleteEvent(event).then((_) {
              Provider.of<EventProvider>(context, listen: false)
                  .deleteEventInProvider(event.id);
              Navigator.of(context).pop();
            });
                },),
        )],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            Container(
              decoration: BoxDecoration(
                border: .all(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey),
                borderRadius: .circular(16),
              ),
              child: ClipRRect(borderRadius: .circular(16),

                child: Image.asset(isDark ? event.category.darkImage : event.category.lightImage,
                  height: screenSize.height * 0.21,
                  width:  double.infinity,
                  fit: .fill,),
              ),
            ),
            Text(event.title,style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: isDark? AppTheme.white:AppTheme.black),),
            Container(
              decoration: BoxDecoration(
                color: isDark? AppTheme.darkblue : AppTheme.white,
              border: .all(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey),
              borderRadius: .circular(16),
            ),
            child: Row(

              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                   width: 44,
                   height: 44,
                   decoration: BoxDecoration(
                   color: isDark? AppTheme.darkblue : AppTheme.offwhite,
                   border: .all(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey),
                   borderRadius: .circular(8),
                   ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset('assets/icons/calendar.svg',
                        colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    width: 24,
                    height: 24,),
                  ),),
                ),
                Column(
                  children: [
                    Text(DateFormat('dd MMMM').format(event.dateTime)),
                    Text(DateFormat('hh:mm a').format(event.dateTime)),
                  ],
                )
              ],
            ),),
            Text('Description' ,style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: isDark? AppTheme.white:AppTheme.black),),
            Container(
              decoration: BoxDecoration(
                color: isDark? AppTheme.darkblue : AppTheme.white,
                border: .all(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey),
                borderRadius: .circular(16),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(event.description,style: textTheme.titleSmall!
                    .copyWith(fontWeight: .w400,color: isDark?
                AppTheme.white:
                AppTheme.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}