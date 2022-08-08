import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  myButton({required this.color,required  this.title,required this.
  onpressed});

  final Color color;
  final String title;
  final VoidCallback onpressed;
   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:  onpressed,
          minWidth: 200,
          height: 42,
          child: Text(
            title,
            style: TextStyle(color: Colors.white,
          ),),
        ),
      ),
    );
  }
}
