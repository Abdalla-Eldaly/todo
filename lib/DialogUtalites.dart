import 'package:flutter/material.dart';

class DialogShown {
  void Showloading(BuildContext context, String message,
      {bool iscancel = true}) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Row(
              children: [
               const CircularProgressIndicator(),
               const SizedBox(
                  width: 12,
                ),
                Text(message),
              ],
            ),
          );
        },
        barrierDismissible: iscancel = false);
  }

  Showmessage(BuildContext context,
      {required String message,
      String? posActiontitle,
      String? negActiontitle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool iscancel = true}) {
    List<Widget> action = [];
    if (posActiontitle != null) {
      action.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },

          child: Text(posActiontitle)));

    }
    if (negActiontitle != null) {
      action.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();

          },
          child: Text(negActiontitle)));
    }
showDialog(context: context,
    builder: (builder){
      return AlertDialog(
        actions: action,
        content: Row(
          children: [Expanded(child: Text(message))],
        ),
      );

    });
  }

  ShowHiding(BuildContext context) {
    Navigator.pop(context);
  }

  void Showmessageerror(BuildContext context, String meassage,
      {iscancelable = true,

        String? posActiontitle,
      }) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          List<Widget> actions=[];
          if(posActiontitle!=null){
            actions.add(TextButton(onPressed: (){Navigator.pop(context);}, child: Text(posActiontitle)));

          }

          return AlertDialog(
            actions: actions,
            content: Row(
              children: [

                Expanded(child: Text(meassage)),

              ],
            ),
          );
        },
        barrierDismissible: iscancelable);
  }
}
