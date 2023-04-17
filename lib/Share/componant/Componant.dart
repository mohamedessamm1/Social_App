import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultFormField(
        {double mywidth = 324,
        InputBorder? EnableBorder,
        InputBorder? FocuseBorder,
        InputBorder? MyBorder,
        Color? mycolor = Colors.white,
        Color? suffixColor,
        String? Hint,
        double PaddingHorizontal = 15,
        double PaddingVertical = 0,
        int? maxlines,
        String? InitalText,
        TextStyle? HintStyle,
        TextStyle? FormFieldStyle,
        String? Function(String?)? onChange,
        String? Function(String?)? onSubmit,
        String? Function(String?)? validate,
        TextEditingController? controller,
        required TextInputType type,
        IconData? suffix,
        Function()? suffixTab,
        bool isPassword = false,
        bool isenable = true,
        double fontsize = 20,
        double bordercircular = 0}) =>
    Container(
      width: mywidth.w,
      child: TextFormField(
        maxLines: maxlines,
        initialValue: InitalText,
        enabled: isenable,
        controller: controller,
        keyboardType: type,
        validator: validate,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        obscureText: isPassword,
        style: FormFieldStyle,
        decoration: InputDecoration(
          hintStyle: HintStyle,
          hintText: Hint,
          suffixIconColor: suffixColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: PaddingHorizontal.w, vertical: PaddingVertical.h),
          filled: true,
          fillColor: mycolor,
          enabledBorder: EnableBorder == null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: Colors.transparent), //<-- SEE HERE
                )
              : EnableBorder,
          focusedBorder: FocuseBorder == null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.transparent),
                )
              : FocuseBorder,
          border: MyBorder == null
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.r))
              : MyBorder,
          suffixIcon: (suffix != null)
              ? InkWell(
                  onTap: suffixTab,
                  radius: 0.0,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    suffix,
                  ),
                )
              : null,
        ),
      ),
    );

Widget defaultButton({
  String Texte = '',
  Color backgroundColor = Colors.red,
  required Function() function,
}) =>
    Center(
      child: Container(
        width: 330.w,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: backgroundColor),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            '${Texte}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );

Widget MyButton({
  required Function() function,
  required String? text,
  int fontsize = 21,
  Color? fontcolor,
  Color? backgroundcolor,
  Color? iconcolor,
  int heightbutton = 44,
  double iconsize = 44,
  int widthbutton = 330,
  IconData? myicon,
  FontWeight? myfontweight,
  String? myimage,
  double? mywidth,
}) =>
    ElevatedButton(
      onPressed: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myicon == null
              ? myimage == null
                  ? Text('')
                  : Image.asset(
                      '${myimage}',
                      scale: 0.7,
                    )
              : Row(
                  children: [
                    Icon(myicon, color: iconcolor, size: iconsize),
                    SizedBox(width: 10.w),
                  ],
                ),
          SizedBox(
            width: mywidth,
          ),
          Text(
            '$text',
            style: TextStyle(
                fontSize: fontsize.sp,
                color: fontcolor,
                fontWeight: myfontweight),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
          fixedSize: Size(widthbutton.w, heightbutton.h),
          backgroundColor: backgroundcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r))),
    );
