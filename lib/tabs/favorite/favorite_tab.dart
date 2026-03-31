import 'package:evently/app_theme.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late EventProvider eventProvider;


  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
      eventProvider.filterFavoriteEvents(userProvider.currentUser!.favoriteEventsIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
   return Column(
     children: [
       Padding(
         padding: const EdgeInsets.all(16.0),
         child: DefaultTextFormField(type: DefaultTextFormFieldType.search,
           hintText: 'Search for event',
           onChanged: (query){},
           suffixIconImageName: 'search',),
       ),
      Expanded(
         child: ListView.separated(
             padding: EdgeInsets.symmetric(horizontal: 16),
             itemBuilder: (_,index) => EventItem(eventProvider.favoriteEvents[index]),
             separatorBuilder:(_,_) => SizedBox(height: 16,),
            itemCount: eventProvider.favoriteEvents.length),
       )

     ],

   );

  }
}