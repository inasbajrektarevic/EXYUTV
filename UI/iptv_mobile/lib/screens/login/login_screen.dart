import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/auth_request.dart';
import '../../providers/login_provider.dart';
import '../home/home_screen.dart';
import '../registration/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isFailed = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _errorMessageController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _errorMessageController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    bool result = await LoginProvider.login(
        AuthRequest(_usernameController.text, _passwordController.text));
    if (result) {
      Navigator.popAndPushNamed(context, HomeScreen.routeName);
    } else {
      setState(() {
        isFailed = true;
        _errorMessageController.text = "Korisničko ime ili lozinka su pogrešni";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0072ff), Color(0xFF00c6ff)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxHeight: 500),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/smart-tv.png', height: 100),
                      SizedBox(height: 10),
                      Text(
                        'Dobrodošli u IPTV',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 15),
                      if (isFailed)
                        Text(
                          _errorMessageController.text,
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      SizedBox(height: 10),
                      _buildTextField(
                        controller: _usernameController,
                        label: "Korisničko ime",
                        icon: Icons.person,
                      ),
                      SizedBox(height: 15),
                      _buildTextField(
                        controller: _passwordController,
                        label: "Lozinka",
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      SizedBox(height: 20),
                      _buildButtonRow(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                _login();
              }
            },
            child: _buildGradientButton(
              text: "Login",
              icon: Icons.login,
              colors: [Color(0xFF0072ff), Color(0xFF00c6ff)],
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            },
            child: _buildGradientButton(
              text: "Registracija",
              icon: Icons.app_registration,
              colors: [Color(0xFF00c853), Color(0xFFb2ff59)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton({required String text, required IconData icon, required List<Color> colors}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
