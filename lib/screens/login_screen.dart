import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  Widget _buildPhoneNumberInput() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone, color: Colors.grey),
        labelText: "Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (!RegExp(r'^\+?\d{10,}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text("Login", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildHelpCard(String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Stack(
        children: [
          // Background Shape
          ClipPath(
            clipper: BackgroundClipper(),
            child: Container(
              height: screenSize.height * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Main Content wrapped in SingleChildScrollView
          SingleChildScrollView(
            child: Center(
              child: isLandscape
                  ? Column(
                children: [
                  SizedBox(height: screenSize.height * 0.4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPhoneNumberInput(),
                                SizedBox(height: 20),
                                _buildLoginButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildHelpCard(
                              "Need Help?",
                              "Contact the developer.",
                                  () {
                                // Navigate to help page or show a dialog
                              },
                            ),
                            _buildHelpCard(
                              "Create an Account",
                              "Sign up if you don't have an account.",
                                  () {
                                // Navigate to registration page
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenSize.height * 0.45),
                  // Phone Number Input
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildPhoneNumberInput(),
                          SizedBox(height: 20),
                          _buildLoginButton(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Displaying additional info as ListTiles
                  _buildHelpCard(
                    "Need Help?",
                    "Contact the developer.",
                        () {
                      // Navigate to help page or show a dialog
                    },
                  ),
                  _buildHelpCard(
                    "Create an Account",
                    "Sign up if you don't have an account.",
                        () {
                      // Navigate to registration page
                    },
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

// Custom Clipper for Background Shape
class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
