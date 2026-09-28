import 'package:flutter/material.dart';  
  
Widget customButton(String texto, Color cor, VoidCallback funcao) {  
  return Padding(  
    padding: EdgeInsets.only(bottom: 10),  
    child: ElevatedButton(  
      onPressed: funcao,  
      style: ElevatedButton.styleFrom(  
        backgroundColor: cor,  
        foregroundColor: Colors.white,  
        minimumSize: Size(double.infinity, 50),  
      ),  
      child: Text(texto),  
    ),  
  );  
}