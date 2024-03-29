import 'package:checklist/authentication_bloc/bloc.dart';
import 'package:checklist/register/bloc/register_bloc.dart';
import 'package:checklist/register/ui/register_button.dart';
import 'package:checklist/todo/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  late RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _registerBloc = context.read<RegisterBloc>();
    _nameController.addListener(_onNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              CustomSnackBar.show(
                title: 'Registering...',
                icon: const CircularProgressIndicator(),
              ),
            );
        }
        if (state.isSuccess) {
          context.read<AuthenticationBloc>().add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              CustomSnackBar.show(
                title: 'Register Failure!',
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error),
              ),
            );
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(30),
                                    fontFamily: "Poppins-Medium",
                                    letterSpacing: .6,
                                    color: const Color(0xFF5d74e3),
                                  ),
                                ),
                              ),
                              RegisterButton(
                                onPressed: isRegisterButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null,
                              ),
                            ]),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Create Account",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(42),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6,
                                    color: Theme.of(context).dividerColor)),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                        TextFormField(
                          controller: _nameController,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            return !state.isNameValid
                                ? 'Plase enter a name'
                                : null;
                          },
                          cursorColor: const Color(0xFF5d74e3),
                          autofocus: true,
                          style: Theme.of(context).textTheme.headline1,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "name",
                              errorStyle:
                                  const TextStyle(fontFamily: 'Poppins-Medium'),
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        TextFormField(
                          controller: _emailController,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            return !state.isEmailValid ? 'Invalid Email' : null;
                          },
                          cursorColor: const Color(0xFF5d74e3),
                          autofocus: true,
                          style: Theme.of(context).textTheme.headline1,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "email",
                              errorStyle:
                                  const TextStyle(fontFamily: 'Poppins-Medium'),
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            return !state.isPasswordValid
                                ? 'Invalid Password'
                                : null;
                          },
                          style: Theme.of(context).textTheme.headline1,
                          decoration: InputDecoration(
                              hintText: "Password",
                              errorStyle:
                                  const TextStyle(fontFamily: 'Poppins-Medium'),
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onNameChanged() {
    _registerBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

// Future<void> signIn(BuildContext context) async {
//   print('Called');
//   final formState = _formKey.currentState;
//   print(_email);
//   if (formState.validate()) {
//     formState.save();
//     try {
//       AuthResult result = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: _email, password: _password);
//       FirebaseUser user = result.user;
//       user.sendEmailVerification();
//       Navigator.of(context).pop();
//     } catch (e) {
//       _showError = true;
//       print(e.message);
//     }
//   }
// }
