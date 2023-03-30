 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';





 Widget defaultFormField(
     {
       Color? mycolor,
       Color? suffixColor,
       String? Function(String?)? onChange,
       String? Function(String?)? onSubmit,
       String? Function(String?)? validate,
       required TextEditingController controller,
       required TextInputType type,
       IconData? suffix,
       Function()? suffixTab,
       bool isPassword = false,
       bool isenable = true,
       double fontsize = 20,
       double bordercircular = 0}) =>
     Container(
       width: 324.w,
       child: TextFormField(
         enabled: isenable,
         controller: controller,
         keyboardType: type,
         validator: validate,
         onFieldSubmitted: onSubmit,
         onChanged: onChange,
         obscureText: isPassword,
         style: const TextStyle(fontWeight: FontWeight.w500),
         decoration: InputDecoration(
           suffixIconColor: suffixColor,
           contentPadding:
           EdgeInsets.symmetric(
               horizontal: 15.w),
           filled: true,
           fillColor: Colors.white,
           enabledBorder:
           OutlineInputBorder(
             borderRadius:
             BorderRadius.circular(
                 10.r),
             borderSide: BorderSide(
                 color: Colors.grey
                     .shade200), //<-- SEE HERE
           ),
           focusedBorder:
           OutlineInputBorder(
             borderRadius:
             BorderRadius.circular(
                 10.r),
             borderSide: BorderSide(
                 color: Colors.grey
                     .shade400), //<-- SEE HERE
           ),
           border: OutlineInputBorder(
               borderRadius:
               BorderRadius.circular(
                   10.r)),
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
   String Texte='',
   Color backgroundColor = Colors.red,
   required Function() function,
 }) =>
     Center(
       child: Container(
         width: 330.w,
         height: 50.h,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10.r),
             color: backgroundColor),
         child: MaterialButton(
           onPressed: function,
           child: Text(
             '${Texte}',
             style:  TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w600),
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
              ? myimage==null? Text(''): Image.asset('${myimage}',scale: 0.7,)
              : Row(
            children: [
              Icon(myicon, color: iconcolor, size: iconsize),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(width: mywidth,),
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