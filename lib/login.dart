import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard_page.dart'; // Impor halaman dashboard
import 'register_page.dart'; // Impor halaman register
import 'forgot_password_page.dart'; // Impor halaman lupa password

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // Untuk menyembunyikan/menampilkan password
  String _message = '';

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // URL endpoint API login
    const String url = 'http://localhost/latlogin/login.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email, 
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['value'] == 1) {
          // Jika login berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        } else {
          // Jika login gagal
          setState(() {
            _message = jsonResponse['message'];
          });
        }
      } else {
        setState(() {
          _message = 'Terjadi kesalahan, silakan coba lagi.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Tidak dapat terhubung ke server.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration:   const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/wallpaper20.jpg'), // Gambar background
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Konten halaman login di atas background
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo berbentuk lingkaran
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 24),

                  // TextField email dengan desain kapsul dan ikon email
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // TextField password dengan ikon mata untuk menampilkan/menyembunyikan password
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),

                  // Link Lupa Password di bawah isian Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()),
                        );
                      },
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tombol login dan register dalam satu row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Pesan error
                  Text(
                    _message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 100),

                  // Login dengan sosial media
                  const Text(
                    "Atau login dengan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600 , backgroundColor: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/instagram.jpg'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/facebook.jpg'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/telegram.jpg'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/twitter.jpg'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}