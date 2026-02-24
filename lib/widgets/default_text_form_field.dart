import 'package:evently/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
enum DefaultTextFormFieldType {auth, search}
class DefaultTextFormField extends StatefulWidget{
  DefaultTextFormFieldType type;
  String hintText;
  void Function(String)? onChanged;
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? prifixIconImageName;
  String? suffixIconImageName;
  bool isPassword ;


  DefaultTextFormField({
    required this.type,
    required this.hintText,
  this.onChanged,
  this.validator,
  this.controller,
  this.prifixIconImageName,
  this.suffixIconImageName,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {

  late bool isObscure = widget.isPassword ? true : false;
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return TextFormField(
      decoration: InputDecoration(hintText: widget.hintText,
      prefixIcon: widget.prifixIconImageName == null ? null : Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset('assets/icons/${widget.prifixIconImageName}.svg',
          colorFilter: (widget.type == DefaultTextFormFieldType.search)? .mode(primaryColor, BlendMode.srcIn)
              : .mode(AppTheme.greyIcon, BlendMode.srcIn),),
      ),
      suffixIcon: widget.suffixIconImageName== null && widget.isPassword? IconButton(
          onPressed:(){
            isObscure = !isObscure;
            setState(() {});
          },
          icon: Icon(isObscure?  Icons.visibility_outlined : Icons.visibility_off_outlined
            , color: AppTheme.greyIcon,)):
      widget.suffixIconImageName == null ? null:
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset('assets/icons/${widget.suffixIconImageName}.svg',
            colorFilter: (widget.type == DefaultTextFormFieldType.search)? .mode(primaryColor, BlendMode.srcIn)
                : .mode(AppTheme.greyIcon, BlendMode.srcIn)
      ),
      )
      ),
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isObscure,

    );
  }
}