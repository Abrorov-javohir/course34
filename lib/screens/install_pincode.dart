import 'package:flutter/material.dart';

class InstallPincode extends StatefulWidget {
  const InstallPincode({super.key});

  @override
  State<InstallPincode> createState() => _InstallPincodeState();
}

class _InstallPincodeState extends State<InstallPincode> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [TextField()],
      ),
    );
  }
}