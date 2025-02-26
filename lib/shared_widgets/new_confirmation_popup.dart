import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_retiree/shared_widgets/input_form_field.dart';

class SecondConfirmationPopup extends StatefulWidget {
  const SecondConfirmationPopup({super.key});

  @override
  State<SecondConfirmationPopup> createState() =>
      _SecondConfirmationPopupState();
}

class _SecondConfirmationPopupState extends State<SecondConfirmationPopup> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 428.w,
          ),
          Container(
            width: 350.w,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.w)),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "LogOut Confirmation",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("Are you absolutely sure to logOut your account?",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 20.h,
                  ),
                  InputFormField(
                    controller: textController,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: "Password",
                    hintText: "xxxxxx",
                    prefixIcon: Icons.lock_outline_rounded,
                    validateMode: AutovalidateMode.disabled,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.red.withOpacity(0.4),
                            customBorder: const StadiumBorder(),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.red, width: 1.5.w)),
                                width: 110.w,
                                height: 45.h,
                                child: SizedBox(
                                  width: 90.w,
                                  height: 30.h,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ))),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.red.withOpacity(0.4),
                            customBorder: const StadiumBorder(),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: Colors.redAccent[400],
                                    border: Border.all(
                                        color: Colors.red, width: 1.5.w)),
                                width: 110.w,
                                height: 45.h,
                                child: SizedBox(
                                  width: 90.w,
                                  height: 30.h,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Delete".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
