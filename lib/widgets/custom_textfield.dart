import 'package:flutter/material.dart';  
  
Widget customTextField(String texto, IconData icone, TextEditingController controller) {  
  return Padding(  
    padding: EdgeInsets.only(bottom: 10),  
    child: TextField(  
      controller: controller,  
      keyboardType: TextInputType.number,  
      decoration: InputDecoration(  
        labelText: texto,  
        prefixIcon: Icon(icone),  
        border: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(12),  
        ),  
      ),  
    ),  
  );  
}