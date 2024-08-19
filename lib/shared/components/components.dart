import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../cubit/cubit.dart';
import '../cubit/status.dart';

Widget bulid_textFormField(
        {VoidCallback? fun,
        required TextEditingController email,
        TextInputType? type,
        required String text,
        required IconData icons}) =>
    TextFormField(
      onChanged: on_changed,
      validator: validator,
      controller: email,
      onTap: fun,
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "$text",
        labelStyle: TextStyle(
          fontSize: 10.sp,
        ),
        prefixIcon: Icon(
          icons,
          size: 7.w,
        ),
      ),
    );

Widget bulid_textFromFieldTime(
        {VoidCallback? fun,
        required TextEditingController email,
        TextInputType? type,
        required String text,
        required IconData icons}) =>
    TextFormField(
      onChanged: on_changed,
      validator: validator_time,
      controller: email,
      onTap: fun,
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "$text",
        labelStyle: TextStyle(
          fontSize: 10.sp,
        ),
        prefixIcon: Icon(
          icons,
          size: 7.w,
        ),
      ),
    );

Widget bulid_textFromFieldDate(
        {VoidCallback? fun,
        required TextEditingController email,
        TextInputType? type,
        required String text,
        required IconData icons}) =>
    TextFormField(
      enabled: true,
      onChanged: on_changed,
      validator: validator_Date,
      controller: email,
      onTap: fun,
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "$text",
        labelStyle: TextStyle(
          fontSize: 10.sp,
        ),
        prefixIcon: Icon(
          icons,
          size: 7.w,
        ),
      ),
    );

void on_changed(String value) {
  print(value);
}

String? validator(String? value) {
  if (value!.isEmpty) {
    return "title must not be empty";
  }
  return null;
}

String? validator_time(String? value) {
  if (value!.isEmpty) {
    return "Time must not be empty";
  }
  return null;
}

String? validator_Date(String? value) {
  if (value!.isEmpty) {
    return "Date must not be empty";
  }
  return null;
}

Widget bulid_New(item, context) => Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: GestureDetector(
          onTap: () {
            var email = TextEditingController();
            var time = TextEditingController();
            var date = TextEditingController();
            time.text = item["time"];
            email.text = item["title"];
            date.text = item["date"];
            AppCubit.get(context).color = item["color"];
            var form = GlobalKey<FormState>();
            final Alert = AlertDialog(
              content: Container(
                color: Colors.white,
                height: 50.h,
                width: 100.w,
                child: Form(
                  key: form,
                  child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            bulid_textFormField(
                              icons: Icons.title,
                              type: TextInputType.name,
                              text: "Task Title",
                              email: email,
                            ),
                            SizedBox(
                              height: 3.h,
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
                                  date.text = DateFormat.yMMMd().format(value!);
                                });
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Text(
                                "Choose Color :",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).colors(0xFF42A5F5);
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF42A5F5),
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).colors(3426920849);
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                        color: Color(3426920849),
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).colors(4294951175);
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                        color: Color(4294951175),
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).colors(0xffb51248);
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xffb51248),
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (form.currentState!.validate() &&
                                      AppCubit.get(context).color != 0) {
                                    AppCubit.get(context).updateDataOFElement(
                                        email.text,
                                        time.text,
                                        date.text,
                                        AppCubit.get(context).color,
                                        item['id']);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );

            showDialog(
              context: context,
              builder: (context) => Alert,
            );
          },
          child: Container(
            height: 15.h,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(1.h)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: CircleAvatar(
                    radius: 4.5.h,
                    backgroundColor: Color(item["color"]),
                    child: Text(
                      "${item["time"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      child: Text(
                        "${item["title"]}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "${item["date"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 9.sp),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      AppCubit.get(context)
                          .updatesDataForElement("Done", 1, item["id"]);
                    },
                    icon: Icon(
                      Icons.check_box,
                      size: 3.h,
                      color: Colors.green,
                    )),
                IconButton(
                    onPressed: () {
                      AppCubit.get(context)
                          .updatesDataForElement("Archive", 2, item["id"]);
                    },
                    icon: Icon(
                      Icons.archive,
                      size: 3.h,
                      color: Colors.black45,
                    ))
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteElement(
          item["id"],
        );
      },
    );

Widget buildTaskFormat(item, context) => Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Container(
          height: 15.h,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(1.h)),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: CircleAvatar(
                  radius: 4.5.h,
                  backgroundColor: Color(item["color"]),
                  child: Text(
                    "${item["time"]}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    child: Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${item["date"]}",
                    style: TextStyle(color: Colors.grey, fontSize: 9.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updatesDataForElement("Done", 1, item["id"]);
                  },
                  icon: Icon(
                    Icons.check_box,
                    size: 3.h,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updatesDataForElement("Archive", 2, item["id"]);
                  },
                  icon: Icon(
                    Icons.archive,
                    size: 3.h,
                    color: Colors.black45,
                  ))
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteElement(
          item["id"],
        );
      },
    );

Widget buildListOfTask(List<Map> task, String typeTask) {
  if (task.length > 0) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          Widget? widget;
          if (typeTask == "newTask") {
            widget = bulid_New(task[index], context);
          } else if (typeTask == "doneTask") {
            widget = buildTaskFormat(task[index], context);
          } else {
            widget = buildTaskFormat(task[index], context);
          }
          return widget;
        },
        separatorBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(start: 2.w, end: 2.w),
              child: Container(
                width: double.infinity,
                height: 0.1.h,
                color: Colors.grey[300],
              ),
            ),
        itemCount: task.length);
  } else {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 10.h,
            color: Colors.grey,
          ),
          Text(
            "No Tasks Yet, Please Add Some Tasks",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

Widget ConditionalBuilders(context) {
  if (State is! LoadData) {
    return AppCubit.get(context).Screen[AppCubit.get(context).index];
  } else {
    return Center(child: CircularProgressIndicator());
  }
}
