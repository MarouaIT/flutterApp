import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  double radius = 10.0,
  Function? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function;
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: Colors.blue,
      ),
    );

Widget defaultFormField({
  TextEditingController? controller,
  TextInputType? type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  Function? validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        onChanged: (s) {
          onChange!(s);
        },
        validator: (s) {
          validate!(s);
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null ? Icon(suffix) : null,
          border: const OutlineInputBorder(),
        ));
