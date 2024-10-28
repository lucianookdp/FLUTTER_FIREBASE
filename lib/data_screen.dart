import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController dataController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    dataController.dispose();
    super.dispose();
  }

  Future<void> _addData() async {
    try {
      await FirebaseFirestore.instance
          .collection('dados')
          .add({'texto': dataController.text});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dados adicionados com sucesso!')),
      );
      dataController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar dados: $e')),
      );
    }
  }

  void _animateIcon() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envio de Dados com Animação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: dataController,
              decoration: InputDecoration(
                labelText: 'Digite algo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addData();
                _animateIcon();
              },
              child: Text('Enviar e Animar'),
            ),
            SizedBox(height: 20),
            RotationTransition(
              turns: _animationController.drive(Tween(begin: 0.0, end: 1.0)),
              child: Icon(Icons.refresh, size: 100, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
