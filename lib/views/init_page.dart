import 'package:flutter_bloc_bp/views/auth/ui/login_page.dart';
import 'package:flutter/material.dart';


class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
