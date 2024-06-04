import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/widgets/snackbar.dart';
import 'package:flutter_application_1/services/authentication.dart';
import 'package:flutter_application_1/theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  bool passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthServices().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "Success") {
      setState(() {
        isLoading = true;
      });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  void signInWithGoogle() async {
    String res = await AuthServices().signInWithGoogle();

    if (res == "Success") {
      setState(() {
        isLoading == true;
      });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: passwordVisible ? false : true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: loginUser,
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Divider(),
                  width: Metrics.width(context) * 0.35,
                ),
                Container(
                  child: Center(child: Text("Or")),
                  width: Metrics.width(context) * 0.15,
                ),
                Container(
                  child: Divider(),
                  width: Metrics.width(context) * 0.35,
                ),
              ],
            ),
            Center(
              child: MaterialButton(
                onPressed: signInWithGoogle,
                child: Image.asset(
                  'lib/assets/images/google.png',
                  fit: BoxFit.contain,
                  width: Metrics.width(context) * 0.09,
                ),
                minWidth: Metrics.width(context) * 0.07,
              ),
            )
          ],
        ),
      ),
    );
  }
}
