import 'dart:math';  
import 'package:flutter/material.dart';  
import 'widgets/custom_textfield.dart';  
import 'widgets/custom_button.dart';  
import 'widgets/painel_resultados.dart';  
  
void main() {  
  runApp(const MeuApp());  
}  
  
class MeuApp extends StatelessWidget {  
  const MeuApp({super.key});  
  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      debugShowCheckedModeBanner: false,  
      home: const TelaSimulador(),  
    );  
  }  
}  
  
class TelaSimulador extends StatefulWidget {  
  const TelaSimulador({super.key});  
  
  @override  
  State<TelaSimulador> createState() => _TelaSimuladorState();  
}  
  
class _TelaSimuladorState extends State<TelaSimulador> {  
  final valorInicialController = TextEditingController();  
  final aporteController = TextEditingController();  
  final jurosController = TextEditingController();  
  final mesesController = TextEditingController();  
  final metaController = TextEditingController();  
  
  double? montanteFinal;  
  double? totalInvestido;  
  double? lucro;  
  String situacaoMeta = '';  
  String perfil = '';  
  
  void _mostrarSnackbar(String mensagem) {  
    ScaffoldMessenger.of(context).showSnackBar(  
      SnackBar(content: Text(mensagem)),  
    );  
  }  
  
  void _calcular() {  
    final campos = [  
      valorInicialController,  
      aporteController,  
      jurosController,  
      mesesController,  
      metaController,  
    ];  
  
    if (campos.any((c) => c.text.trim().isEmpty)) {  
      _mostrarSnackbar("Preencha todos os campos");  
      return;  
    }  
  
    final p = double.tryParse(valorInicialController.text);  
    final aporte = double.tryParse(aporteController.text);  
    final juros = double.tryParse(jurosController.text);  
    final meses = int.tryParse(mesesController.text);  
    final meta = double.tryParse(metaController.text);  
  
    if ([p, aporte, juros, meta].contains(null) || meses == null || meses <= 0) {  
      _mostrarSnackbar("Valores inválidos");  
      return;  
    }  
  
    final i = juros! / 100;  
    final montante = p! * pow(1 + i, meses);  
    final investido = p + (aporte! * meses);  
  
    setState(() {  
      montanteFinal = montante;  
      totalInvestido = investido;  
      lucro = montante - investido;  
      situacaoMeta = montante >= meta!  
          ? "Meta alcançada"  
          : "Faltam R\$ ${(meta - montante).toStringAsFixed(2)} para atingir a meta";  
      perfil = juros < 0.5  
          ? "Conservador"  
          : (juros <= 1.5 ? "Moderado" : "Agressivo");  
    });  
  
    _mostrarSnackbar("Simulação realizada com sucesso");  
  }  
  
  void _limparTudo() {  
    setState(() {  
      for (var c in [  
        valorInicialController,  
        aporteController,  
        jurosController,  
        mesesController,  
        metaController,  
      ]) {  
        c.clear();  
      }  
      montanteFinal = null;  
      totalInvestido = null;  
      lucro = null;  
      situacaoMeta = '';  
      perfil = '';  
    });  
    Navigator.pop(context);  
    _mostrarSnackbar("Dados removidos com sucesso");  
  }  
  
  void _carregarExemplo() {  
    valorInicialController.text = "1000";  
    aporteController.text = "500";  
    jurosController.text = "1.2";  
    mesesController.text = "24";  
    metaController.text = "30000";  
    Navigator.pop(context);  
    _mostrarSnackbar("Dados de exemplo carregados");  
  }  
  
  void _mostrarDialogLimpar() {  
    showDialog(  
      context: context,  
      builder: (context) => AlertDialog(  
        title: const Text("Limpar dados"),  
        content: const Text("O que deseja fazer?"),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.pop(context),  
            child: const Text("Cancelar"),  
          ),  
          TextButton(  
            onPressed: _limparTudo,  
            child: const Text("Limpar tudo"),  
          ),  
          TextButton(  
            onPressed: _carregarExemplo,  
            child: const Text("Carregar exemplo"),  
          ),  
        ],  
      ),  
    );  
  }  
  
  @override  
  void dispose() {  
    for (var c in [  
      valorInicialController,  
      aporteController,  
      jurosController,  
      mesesController,  
      metaController,  
    ]) {  
      c.dispose();  
    }  
    super.dispose();  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: const Text("Simulador Financeiro")),  
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          children: [  
            customTextField("Valor Inicial", Icons.attach_money, valorInicialController),  
            customTextField("Aporte Mensal", Icons.savings, aporteController),  
            customTextField("Taxa de Juros (%)", Icons.percent, jurosController),  
            customTextField("Quantidade de Meses", Icons.calendar_month, mesesController),  
            customTextField("Meta Financeira", Icons.flag, metaController),  
            customButton("Calcular", Colors.green, _calcular),  
            customButton("Limpar Dados", Colors.orange, _mostrarDialogLimpar),  
            PainelResultados(  
              montanteFinal: montanteFinal,  
              totalInvestido: totalInvestido,  
              lucro: lucro,  
              situacaoMeta: situacaoMeta,  
              perfil: perfil,  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}