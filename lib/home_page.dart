import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double imcResult = 0.0;

  List<String> pesos = [
    'Baixo peso',
    'Peso normal',
    'Sobrepeso',
    'Obesidade Grau I',
    'Obesidade Grau II',
    'Obesidade Grau III'
  ];

  void calculateImc({required double weight, required double height}) {
    final double imc = weight / (height * height);

    setState(() {
      imcResult = imc;
    });
  }

  void clearResult() {
    setState(() {
      imcResult = 0.0;
      heightController.clear();
      weightController.clear();
    });
  }

  String imcCartegory({required double imcResult}) {
    if (imcResult < 1) {
      return '';
    } else if (imcResult >= 1 && imcResult < 18.5) {
      return pesos[0];
    } else if (imcResult >= 18.5 && imcResult <= 24.9) {
      return pesos[1];
    } else if (imcResult >= 25.0 && imcResult <= 29.9) {
      return pesos[2];
    } else if (imcResult >= 30.0 && imcResult <= 34.9) {
      return pesos[3];
    } else if (imcResult >= 35.0 && imcResult <= 39.0) {
      return pesos[4];
    } else {
      return pesos[5];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Calculadora de IMC'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Digite seu peso:'),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Digite sua altura:'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                    child: FilledButton(
                  child: const Text('Calcular'),
                  onPressed: () {
                    if (weightController.text.isNotEmpty &&
                        heightController.text.isNotEmpty) {
                      calculateImc(
                          weight: double.parse(weightController.text),
                          height: double.parse(heightController.text));
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            imcResult > 1.0
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        const Text('Resultado: '),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          imcResult.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 35.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          imcCartegory(imcResult: imcResult),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 20.0,
                  ),
            imcResult > 1
                ? Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        child: const Text('Limpar'),
                        onPressed: () {
                          clearResult();
                        },
                      ))
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      )),
    );
  }
}
