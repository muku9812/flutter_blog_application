import 'package:flutter/material.dart';
import 'package:my_blog/controller/registrationController.dart';
import 'package:my_blog/utilities/utilities.dart';
import 'package:provider/provider.dart';

import '../routes/routesName.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final FocusNode _userFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.alphacoders.com%2F458%2F458169.jpg&f=1&nofb=1&ipt=9a290af7be5d2ca6f535fc1dccd47d69b7ecb1d9b6e1ca8e18d308b1cb79ac33&ipo=images'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.07, top: height * 0.07),
                      child: const Text(
                        'Register \n Now !',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-happy-young-woman-looking-camera_23-2147892777.jpg?w=2000'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * .07,
                      left: width * 0.09,
                      right: width * 0.09),
                  child: TextFormField(
                    controller: _userNameController,
                    focusNode: _userFocus,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: Colors.black38,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * .02,
                      left: width * 0.09,
                      right: width * 0.09),
                  child: TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: Colors.black38,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * .02,
                      left: width * 0.09,
                      right: width * 0.09),
                  child: ValueListenableBuilder(
                      valueListenable: _obsecurePassword,
                      builder: (context, value, child) {
                        return TextFormField(
                          obscureText: _obsecurePassword.value,
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                              child: Icon(
                                _obsecurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black38,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: Colors.black38,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black87),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black87),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        context
                            .read<RegistrationController>()
                            .registerPostApi(
                              _userNameController.text.toString(),
                              _emailController.text.toString(),
                              _passwordController.text.toString(),
                            )
                            .then((value) {
                          if (value.token == '' || value.token == null) {
                            Utilities.flushBarErrorMessage(
                                value.message.toString(), context);
                          } else {
                            Navigator.pushReplacementNamed(
                                context, RoutesName.home);
                          }
                        });
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                        ),
                        child: Center(
                            child: const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * .020),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutesName.login);
                    },
                    child: const Text(
                      "Already have account ? Login",
                      style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
