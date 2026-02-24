import 'package:evently/app_theme.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/cupertino.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
             itemBuilder: (_,index) => EventItem(),
             separatorBuilder:(_,_) => SizedBox(height: 16,),
             itemCount: 10),
       )

     ],

   );

  }

}