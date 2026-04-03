import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/ui_utils.dart';
import 'package:evently/widgets/arrow_back.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CreateEventScreen extends StatefulWidget{
  static const String routename = 'createEvent';


  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  CategoryModel selectedCategory = CategoryModel.categories.first;
  int currentIndex = 0 ;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  EventModel? event;


  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      event = ModalRoute
          .of(context)!
          .settings
          .arguments as EventModel?;
      if (event != null) {
        title.text = event!.title;
        description.text = event!.description;
        selectedDate = event!.dateTime;
        selectedTime = TimeOfDay.fromDateTime(event!.dateTime);
        selectedCategory = event!.category;
        currentIndex = CategoryModel.categories.indexOf(selectedCategory);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Color primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Size screenSize = MediaQuery.sizeOf(context);
    bool isEdit = event != null;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: ArrowBack() , title: Text(isEdit? 'Edit event':' Add Event')
      ),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: .all(color: isDark ? AppTheme.lightblue : AppTheme.lightgrey),
                borderRadius: .circular(16),
              ),
              child: ClipRRect(borderRadius: .circular(16),

                  child: Image.asset(
                      isDark?  selectedCategory.darkImage
                          :  selectedCategory.lightImage,
                  height: screenSize.height * 0.21,
                  width:  double.infinity,
                  fit: .fill,),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16),
            child: DefaultTabController(
              length: CategoryModel.categories.length ,
              child: TabBar(tabs: CategoryModel.categories
                  .map(
                      (category) => TabItem(name: category.name,
                        isSelected: currentIndex == CategoryModel.categories.indexOf(category),
                        iconPath: category.iconPath,
                        icon: category.icon,) ).toList(),
                indicatorColor: Colors.transparent,
                isScrollable: true,
                dividerColor: Colors.transparent,
                padding: EdgeInsets.only(left: 16),
                labelPadding: EdgeInsets.only(right: 8),
                tabAlignment: .start,
                onTap: (index){
                if (currentIndex == index) return;
                currentIndex = index;
                selectedCategory = CategoryModel.categories[currentIndex];
                setState(() {});
                },
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              bottom: true,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Title',style: textTheme.titleMedium!.copyWith(color: isDark ? AppTheme.white : AppTheme.black ,fontWeight: .w500),
                    ),
                    SizedBox(height: 8,),
                    DefaultTextFormField(type:DefaultTextFormFieldType.add , hintText: 'Event Title',controller: title,),
                    SizedBox(height: 8,),
                    Text('Description',style: textTheme.titleMedium!.copyWith(color: isDark ? AppTheme.white : AppTheme.black ,fontWeight: .w500),
                    ),
                    SizedBox(height: 8,),
                    DefaultTextFormField(type:DefaultTextFormFieldType.add , hintText: 'Event description' , maxLine: 4,controller: description,),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/date.svg' ,colorFilter: .mode( primaryColor , BlendMode.srcIn ),),
                        SizedBox(width: 8,),
                        Text('Event Date',style: textTheme.titleMedium!.copyWith(color: isDark ? AppTheme.white : AppTheme.black ,fontWeight: .w500)),
                          Spacer(),
                          TextButton(onPressed: () async {
                            DateTime? date = await showDatePicker(context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days : 365)),
                              initialDate: selectedDate,
                              initialEntryMode: .calendarOnly,
                            );
                            if(date != null){
                              selectedDate = date;
                              setState(() {});
                            }
                          }
                          , child: Text(selectedDate == null
                                  ? 'Choose date'
                              : dateFormat.format(selectedDate!),
                              ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/time.svg' ,colorFilter: .mode( primaryColor , BlendMode.srcIn ),),
                        SizedBox(width: 8,),
                        Text('Event Time',style: textTheme.titleMedium!.copyWith(color: isDark ? AppTheme.white : AppTheme.black ,fontWeight: .w500)),
                        Spacer(),
                        TextButton(onPressed: ()async {
                          TimeOfDay? time = await showTimePicker(context: context,
                              initialTime: selectedTime ?? TimeOfDay.now()
                          );
                          if(time != null){
                            selectedTime = time;
                            setState(() {});
                          }
                        }, child: Text(selectedTime?.format(context) ?? 'Choose time')),
                      ],
                    ),
                    SizedBox(height: 8,),
                    DefaultElevatedButton(label: isEdit? 'Update event':'Add Event', onPressed: isEdit ?
                    EditEvent : CreateEvent)
                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }

  Future<void> CreateEvent()
  async {
    if(formKey.currentState!.validate() && selectedDate != null && selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute
      );
      EventModel createEvent = EventModel(
          category: selectedCategory,
          title: title.text,
          description: description.text,
          dateTime: dateTime,
          userId:  FirebaseService.getCurrentUserId());
      FirebaseService.createEvent(createEvent).then((_) async{
        await Provider.of<EventProvider>(context,listen: false).getEvents();
        Navigator.of(context).pop();
        UiUtils.showSuccessMessage('Event created successfully');
      } ).catchError((_) {
        UiUtils.showErrorMessage('Failed to create event');
      });

    }
  }

  Future<void> EditEvent()
  async {
    if(formKey.currentState!.validate() && selectedDate != null && selectedTime != null) {
      DateTime dateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute
      );
      EventModel updateEvent = EventModel(
          id: event!.id,
          category: selectedCategory,
          title: title.text,
          description: description.text,
          dateTime: dateTime,
          userId: FirebaseService.getCurrentUserId());
      FirebaseService.updateEvent(updateEvent).then((_) {
        Provider.of<EventProvider>(context, listen: false)
            .updateEventInProvider(updateEvent);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      } );

    }
  }
}