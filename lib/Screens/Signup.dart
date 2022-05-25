import 'package:cowsandbulls/Services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("CowsNBulls",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold))
                        ]),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        validator: (val) => val!.isEmpty
                                            ? "Enter an email"
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                          border: InputBorder.none,
                                          hintText: "gnani@email.com",
                                        ),
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: Colors.white),
                                        child: TextFormField(
                                          validator: (val) => val!.length < 6
                                              ? "Enter a password of 6+ chars"
                                              : null,
                                          obscureText: true,
                                          onChanged: (value) {
                                            setState(() {
                                              password = value;
                                            });
                                          },
                                          style: const TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                          cursorColor: const Color.fromARGB(
                                              255, 253, 225, 75),
                                          decoration: const InputDecoration(
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                            border: InputBorder.none,
                                            hintText: "*********",
                                          ),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18 /
                                              3,
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: TextButton(
                                        onPressed: () async {
                                          //dynamic result = await _auth.SignUpAnon();

                                          // if (result == null) {
                                          //   print("error SignUpg in");
                                          // } else {
                                          //   print('Signed in');
                                          //   print(result.uid);
                                          // }
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // print(email);
                                            // print(password);
                                            dynamic result = await _auth
                                                .registerWithEmailAndPassword(
                                                    email, password);
                                            if (result == null) {
                                              setState(() {
                                                error =
                                                    "Please enter a valid email";
                                              });
                                            }
                                          }
                                        },
                                        child: const Text(
                                          "Sign up",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(20),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'OR',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Signup with Google',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Have an account?",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                          TextButton(
                                              onPressed: () {
                                                widget.toggleView();
                                              },
                                              child: const Text(
                                                "Sign in",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),

                    // Text(
                    //   error,
                    //   style: TextStyle(color: Colors.red, fontSize: 15),
                    // ),
                  ]),
            ),
          ],
        )
      ]),
    ));
  }
}
