import 'package:booking_app/constants.dart';
import 'package:booking_app/models/user.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/screens/login/create_account_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/services/database.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Authentication _authenticationService = Authentication.instance;

  bool _isLoading = false;

  bool _showError = false;
  String errorMessage;

  @override
  void initState() {
    super.initState();

    _isLoading = false;
    _showError = false;
    errorMessage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  backgroundColor: Colors.grey[300],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'booking',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 35,
                          ),
                        ),
                        Text(
                          'app',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Log in to your account to continue.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 36,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              if ((_showError) && (errorMessage != null))
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.1),
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.red,
                                            width: 5,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'A login error occured!',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            errorMessage,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 18),
                                  ],
                                ),
                              Text(
                                'EMAIL ADDRESS',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _emailController,
                                decoration: Constants.decoration(
                                  'Enter your email address...',
                                  Icons.email,
                                ),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Field cannot be empty.";

                                  final bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                  if (!emailValid)
                                    return "Field must be an actual email.";
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 18),
                              Text(
                                'PASSWORD',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _passwordController,
                                decoration: Constants.decoration(
                                  'Enter your password...',
                                  Icons.lock,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Field cannot be empty.";
                                  if (value.length < 8)
                                    return "Field must be at least 8 characters.";
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                onFieldSubmitted: (value) => _login,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "No account yet?",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccountScreen(),
                                ),
                              ),
                              child: Text(
                                'Create one now!',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ClipOval(
                          child: Material(
                            color:
                                Theme.of(context).primaryColor, // button color
                            child: InkWell(
                              splashColor: Colors.red[600], // inkwell color
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              onTap: _login,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
        _showError = false;
        errorMessage = null;
      });

      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      final authResult = await _authenticationService.logIn(email, password);
      if (authResult != null) {
        final BAUser user = authResult;
        if (user.isDisabled) {
          setState(() {
            _isLoading = false;
            _showError = true;
            errorMessage =
                'Your account has been disabled. If you believe this is an error, please contact a member of our team.';
          });

          await Future.delayed(
            Duration(seconds: 5),
          );

          setState(() {
            _isLoading = false;
            _showError = false;
            errorMessage = null;
          });

          return;
        }

        _authenticationService.setCurrentUser(user);
        await Database.instance.load();

        setState(() {
          _isLoading = false;
          _showError = false;
          errorMessage = null;
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
          ModalRoute.withName('/'),
        );

        return;
      }

      setState(() {
        _isLoading = false;
        _showError = true;
        errorMessage = 'Invalid login credentials entered. Please try again.';
      });

      await Future.delayed(
        Duration(seconds: 5),
      );

      setState(() {
        _isLoading = false;
        _showError = false;
        errorMessage = null;
      });
    }
  }
}
