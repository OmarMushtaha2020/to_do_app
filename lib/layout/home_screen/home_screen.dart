import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/status.dart';

class Home_Screen extends StatelessWidget {
  var email = TextEditingController();
  var time = TextEditingController();
  var date = TextEditingController();
  var form = GlobalKey<FormState>();

  var show_bottom = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..creatDd(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
// if (state is InsertToDb){
// AppCubit.get(context).color=null as int;
// }
          if (state is UpdateElementData) {
            AppCubit.get(context).color = 0;
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: show_bottom,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 2.5.h
              ),
              title: Text(
                AppCubit.get(context).Title[AppCubit.get(context).index],
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: ConditionalBuilders(context),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                if (AppCubit.get(context).show) {
                  show_bottom.currentState!
                      .showBottomSheet((context) => Form(
                            key: form,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(1.h),
                                    topEnd: Radius.circular(1.h)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      bulid_textFormField(
                                        icons: Icons.title,
                                        type: TextInputType.name,
                                        text: "Task Title",
                                        email: email,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      bulid_textFromFieldTime(
                                        text: ' Task Time',
                                        icons: Icons.watch_later_outlined,
                                        email: time,
                                        type: TextInputType.datetime,
                                        fun: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            time.text = value!.format(context);
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      bulid_textFromFieldDate(
                                        text: ' Task Date',
                                        icons: Icons.calendar_today,
                                        email: date,
                                        fun: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2030, 8, 1),
                                            firstDate: DateTime(2030, 8, 1),
                                            lastDate: DateTime(2030, 12, 31),
                                          ).then((value) {
                                            date.text = DateFormat.yMMMd()
                                                .format(value!);
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 1.w),
                                        child: Text(
                                          "Choose Color :",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                                  onTap: () {
                                                    if (index == 0) {
                                                      AppCubit.get(context)
                                                          .colors(0xFF42A5F5);
                                                    }
                                                    if (index == 1) {
                                                      AppCubit.get(context)
                                                          .colors(3426920849);
                                                    }
                                                    if (index == 2) {
                                                      AppCubit.get(context)
                                                          .colors(4294951175);
                                                    }
                                                    if (index == 3) {
                                                      AppCubit.get(context)
                                                          .colors(0xffb51248);
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 5.h,
                                                        width: 11.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .listOfColors[
                                                              index],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20.h),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                      width: 3.w,
                                                    ),
                                            itemCount: AppCubit.get(context)
                                                .listOfColors
                                                .length),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    AppCubit.get(context)
                        .changesStatusOfObscuredOfTextForm(Icons.edit, true)
                        .then((value) {
                      email.text = "";
                      time.text = "";
                      date.text = "";
                      AppCubit.get(context).color = 0;
                    });
                  });

                  AppCubit.get(context)
                      .changesStatusOfObscuredOfTextForm(Icons.add, false);
                } else {
                  if (form.currentState!.validate() &&
                      AppCubit.get(context).color != 0) {
                    if (AppCubit.get(context).color != 0) {
                      AppCubit.get(context)
                          .insertToDd(
                              title: email.text,
                              time: time.text,
                              date: date.text,
                              color: AppCubit.get(context).color,
                              value: 0)
                          .then((value) {
                        email.text = "";
                        time.text = "";
                        date.text = "";
                        AppCubit.get(context).color = 0;
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    show_bottom.currentState!
                        .showBottomSheet((context) => Form(
                              key: form,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(30),
                                      topEnd: Radius.circular(30)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        bulid_textFormField(
                                          icons: Icons.title,
                                          type: TextInputType.name,
                                          text: "Task Title",
                                          email: email,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        bulid_textFromFieldTime(
                                          text: ' Task Time',
                                          icons: Icons.watch_later_outlined,
                                          email: time,
                                          type: TextInputType.datetime,
                                          fun: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              time.text =
                                                  value!.format(context);
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        bulid_textFromFieldDate(
                                          text: ' Task Date',
                                          icons: Icons.calendar_today,
                                          email: date,
                                          fun: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2030, 8, 1),
                                              lastDate: DateTime(2030, 8, 1),
                                            ).then((value) {
                                              date.text = DateFormat.yMMMd()
                                                  .format(value!);
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            "color :",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .colors(0xFF42A5F5);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF42A5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .colors(3426920849);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    color: Color(3426920849),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .colors(4294951175);

                                                  // setState(() {
                                                  //   color=4294951175 ;
                                                  // });
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    color: Color(4294951175),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .colors(0xffb51248);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffb51248),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .closed
                        .then((value) {
                      AppCubit.get(context)
                          .changesStatusOfObscuredOfTextForm(Icons.edit, true);
                    });
                  }
                }
              },
              child: Icon(
                AppCubit.get(context).icon,
                color: Colors.white,
              ),
              heroTag: "Add",
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.blue,
              currentIndex: AppCubit.get(context).index,
              selectedLabelStyle: TextStyle(fontSize: 14.sp),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              // iconSize: 100.w,
              unselectedLabelStyle: TextStyle(fontSize: 12.sp),
              onTap: (value) {
                AppCubit.get(context).changeIndexOfBottomNavigation(value);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 3.h,
                    ),
                    label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 3.h,
                    ),
                    label: "Done"),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                    color: Colors.white,
                    size: 3.h,
                  ),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
