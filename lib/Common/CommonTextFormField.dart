import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
String labeltext;
TextInputType? keyboardtype;
String? Function(String?)? Validator;
bool obscuretext;
TextEditingController? controller;
int? Lines;
CommonTextFormField({
  required this.labeltext,
  this.keyboardtype=TextInputType.text,
  this.Validator,
  this.obscuretext=true,
   this.controller,
  this.Lines=1
});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: Lines,
      minLines: Lines,
      controller: controller,
      obscureText: obscuretext ,
      validator:Validator ,

      keyboardType: keyboardtype,
      decoration: InputDecoration(
        labelText: labeltext,
      ),
    );
  }
}
