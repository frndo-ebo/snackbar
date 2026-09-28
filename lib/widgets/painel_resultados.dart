import 'package:flutter/material.dart';  
  
class PainelResultados extends StatelessWidget {  
  final double? montanteFinal;  
  final double? totalInvestido;  
  final double? lucro;  
  final String situacaoMeta;  
  final String perfil;  
  
  const PainelResultados({  
    super.key,  
    this.montanteFinal,  
    this.totalInvestido,  
    this.lucro,  
    required this.situacaoMeta,  
    required this.perfil,  
  });  
  
  String _moeda(double? valor) =>  
      valor == null ? "-" : "R\$ ${valor.toStringAsFixed(2)}";  
  
  Widget _linha(String rotulo, String valor) {  
    return Padding(  
      padding: const EdgeInsets.symmetric(vertical: 6),  
      child: Row(  
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  
        children: [  
          Text(rotulo, style: const TextStyle(fontWeight: FontWeight.w500)),  
          Text(valor),  
        ],  
      ),  
    );  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    if (montanteFinal == null) return const SizedBox.shrink();  
  
    return Card(  
      elevation: 3,  
      margin: const EdgeInsets.only(top: 16),  
      child: Padding(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.stretch,  
          children: [  
            const Text(  
              "Resultados",  
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
            ),  
            const Divider(),  
            _linha("Montante Final", _moeda(montanteFinal)),  
            _linha("Total Investido", _moeda(totalInvestido)),  
            _linha("Lucro", _moeda(lucro)),  
            _linha("Meta", situacaoMeta),  
            _linha("Perfil Financeiro", perfil),  
          ],  
        ),  
      ),  
    );  
  }  
}