import 'package:booking_app/constants.dart';
import 'package:booking_app/models/user.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/services/database.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _authenticationService = Authentication.instance;

  final _scrollController = ScrollController();
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
  Widget build(final BuildContext context) {
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
                        'Create your account to start booking!',
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
                          _scrollController.jumpTo(
                            _scrollController.position.minScrollExtent,
                          );
                        },
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              if ((_showError) && (errorMessage != null))
                                Column(
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
                                            MainAxisAlignment.start,
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'FIRST NAME',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormField(
                                          controller: _firstNameController,
                                          decoration: Constants.decoration(
                                            'Enter your first name...',
                                            Icons.person,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty)
                                              return "Field cannot be empty.";
                                            final RegExp nameRegExp =
                                                RegExp('[a-zA-Z]');
                                            if (!nameRegExp.hasMatch(value))
                                              return "Field must be a valid name.";
                                          },
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'LAST NAME',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormField(
                                          controller: _lastNameController,
                                          decoration: Constants.decoration(
                                            'Enter your last name...',
                                            Icons.person,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty)
                                              return "Field cannot be empty.";
                                            final RegExp nameRegExp =
                                                RegExp('[a-zA-Z]');
                                            if (!nameRegExp.hasMatch(value))
                                              return "Field must be a valid name.";
                                          },
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 18),
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
                                  'Enter your desired password...',
                                  Icons.lock,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Field cannot be empty.";
                                  if (value.length < 8)
                                    return "Field cannot be less than 8 characters.";
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                onFieldSubmitted: (value) {
                                  _scrollController.jumpTo(_scrollController
                                      .position.minScrollExtent);
                                },
                                onTap: () {
                                  _scrollController.jumpTo(_scrollController
                                      .position.maxScrollExtent);
                                },
                              ),
                              SizedBox(height: 18),
                              Text(
                                'CONFIRM PASSWORD',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _confirmPasswordController,
                                decoration: Constants.decoration(
                                  'Enter your password again...',
                                  Icons.lock,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Field cannot be empty.";
                                  if (value.length < 8)
                                    return "Field cannot be less than 8 characters.";
                                  if (value != _passwordController.text)
                                    return "Your passwords do not match.";
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                onFieldSubmitted: (value) {
                                  _scrollController.jumpTo(_scrollController
                                      .position.minScrollExtent);
                                },
                                onTap: () {
                                  _scrollController.jumpTo(_scrollController
                                      .position.maxScrollExtent);
                                },
                              ),
                              SizedBox(
                                height: 175,
                              )
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
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Log in now!',
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
                              onTap: _createAccount,
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

  void _createAccount() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';
      final String email = _emailController.text.trim();
      final String password = _confirmPasswordController.text;

      final authResult =
          await _authenticationService.createAccount(fullName, email, password);
      if (authResult is BAUser) {
        final BAUser user = authResult;
        print(user.fullName);
        _authenticationService.setCurrentUser(user);

        setState(() {
          _isLoading = true;
          _showError = false;
          errorMessage = null;
        });

        await Database.instance.load();

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
        errorMessage = authResult;
      });

      await Future.delayed(
        Duration(seconds: 5),
      );

      setState(() {
        _showError = false;
        errorMessage = null;
      });
    }
  }
}
