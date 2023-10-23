import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
String labeltext;
TextInputType? keyboardtype;
String? Function(String?)? Validator;
bool obscuretext;
TextEditingController? controller;
int? Lines;
IconData? prefixIcon;
final bool? togglePasswordVisibility;
final void Function(bool)? togglePasswordCallback;
CommonTextFormField({
  required this.labeltext,
  this.keyboardtype=TextInputType.text,
  this.Validator,
  this.obscuretext=true,
   this.controller,
  this.Lines=1,
  this.prefixIcon,
  this.togglePasswordVisibility,
  this.togglePasswordCallback,});

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}
bool _passwordVisible = true;
class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.Lines,
      minLines: widget.Lines,
      controller: widget.controller,
      obscureText: widget.obscuretext && _passwordVisible,
      validator:widget.Validator ,

      keyboardType: widget.keyboardtype,
      decoration: InputDecoration(
        labelText: widget.labeltext,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon)
            : null,
        suffixIcon: widget.togglePasswordVisibility != null
            ? IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
              if (widget.togglePasswordCallback != null) {
                widget.togglePasswordCallback!(_passwordVisible);
              }
            });
          },
        )
            : null,
      ),
    );
  }
}



