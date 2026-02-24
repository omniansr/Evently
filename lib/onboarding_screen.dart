import 'package:evently/app_theme.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/models/onboarding_model.dart' show OnboardingModel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

  class OnboardingScreen extends StatefulWidget {
  static const String routename = 'onbording';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

  class _OnboardingScreenState extends State<OnboardingScreen> {

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      lightImage: 'assets/images/lightOnboarding1.png',
      darkImage: 'assets/images/darkOnboarding1.png',
      title: 'Find Events That Inspire You',
      description: "Dive into a world of events crafted to fit your unique interests. "
            "Whether you're into live music, art workshops, professional networking, "
            "or simply discovering new experiences, we have something for everyone. "
            "Our curated recommendations will help you explore, connect, "
            "and make the most of every opportunity around you.", ),
    OnboardingModel(
        lightImage: 'assets/images/lightOnboarding2.png',
        darkImage: 'assets/images/darkOnboarding2.png',
        title: 'Effortless Event Planning',
        description: "Take the hassle out of organizing events with our all-in-one planning tools."
            " From setting up invites and managing RSVPs to scheduling reminders and coordinating details, "
            "we’ve got you covered. Plan with ease and focus on what matters – "
            "creating an unforgettable experience for you and your guests."),
    OnboardingModel(
        lightImage: 'assets/images/lightOnboarding3.png',
        darkImage: 'assets/images/darkOnboarding3.png',
        title: 'Connect with Friends & Share Moments',
        description: "Make every event memorable by sharing the experience with others. "
            "Our platform lets you invite friends, keep everyone in the loop, "
            "and celebrate moments together. Capture and share the excitement with your network, "
            "so you can relive the highlights and cherish the memories.")
  ];

  final PageController _controller = PageController();
  int currentIndex = 0;

  Future<void> finshOnBoarding(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoarding', true);

    Navigator.pushReplacementNamed(context, HomeScreen.routename);
  }
  
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      top:true,
      bottom: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             SizedBox(
               height: 40,
               child: Stack(
                 alignment: .center,
                  children: [
                    if(currentIndex > 0 )
                    Positioned(
                      left: 0,
                      child: InkWell(
                     onTap: (){
                  _controller.previousPage(duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  height: 30,
                  width: 30,
                  decoration:BoxDecoration(
                    color: isDark? AppTheme.darkBlack : AppTheme.white,
                    border: Border.all(color: isDark? AppTheme.darkPrimary : AppTheme.lightgrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                    child: SvgPicture.asset('assets/icons/arrow-left.svg',height: 24,width: 24,
                      colorFilter: ColorFilter.mode(isDark? AppTheme.white : AppTheme.primary, BlendMode.srcIn),)
                    ),),
                ),
                    Center(child: isDark ? Image.asset('assets/images/darkheader.png')
                    :Image.asset('assets/images/header.png')),
                    if(currentIndex < 2 )
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: (){
                          finshOnBoarding(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          height: 30,
                          width: 60,
                          decoration:BoxDecoration(
                              color: isDark?AppTheme.darkBlack:AppTheme.white,
                              border: BoxBorder.all(color: isDark? AppTheme.darkPrimary: AppTheme.lightgrey),
                              borderRadius: BorderRadius.circular(8),
                              ),
                          child: Text('Skip',textAlign: .center,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: isDark? AppTheme.white :AppTheme.primary
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
             ),
              SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemCount: onboardingList.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder:(context,index){
                    return
                     Image.asset( isDark?
                      onboardingList[index].darkImage
                       : onboardingList[index].lightImage,
                      height: 320,
                      fit: BoxFit.fill,
                    ) ;
                    }
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                children: List.generate(
                  onboardingList.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ?  AppTheme.primary
                          : AppTheme.gray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(onboardingList[currentIndex].title,style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 5,),
              Text(onboardingList[currentIndex].description,style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                if (currentIndex < onboardingList.length - 1) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  finshOnBoarding(context);
                }
              },
                child: Text(currentIndex == 2 ?'Get started':'Next',),
              )
            ],
          ),
        ),
      ),
    );
  }
}