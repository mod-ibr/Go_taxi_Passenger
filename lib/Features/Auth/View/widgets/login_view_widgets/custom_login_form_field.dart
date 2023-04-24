// ignore_for_file: must_be_immutable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/Core/Utils/Functions/awesome_dialog_message.dart';
import 'package:taxi/Features/Auth/Model/auth_model.dart';
import 'package:taxi/Features/Auth/ViewModel/cubit/auth_cubit.dart';

import '../../../../../Core/Utils/Functions/animated_navigation.dart';
import '../../../../../Core/Widgets/loading_widget.dart';
import '../../../../../home_view.dart';
import '../../signUpView/signup_view.dart';
import '../authWidgets/custom_button.dart';
import '../authWidgets/custom_button_social_and_logo.dart';
import '../authWidgets/custom_text.dart';
import '../authWidgets/custom_text_form_field.dart';
import '../authWidgets/logo_widget.dart';

import 'package:flutter/material.dart';

class CustomLogInFormField extends StatefulWidget {
  CustomLogInFormField({
    super.key,
    required this.height,
    required this.width,
  });
  final double width, height;
  bool isPasswordVisible = false;

  @override
  State<CustomLogInFormField> createState() => _CustomLogInFormFieldState();
}

class _CustomLogInFormFieldState extends State<CustomLogInFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SucceededAuthState) {
          AwesomeDialogMessage()
              .showSuccessAwesomeDialog(
                  message: 'logged in successfully', context: context)
              .then((value) {
            AnimatedNavigation()
                .navigate(widget: const HomeView(), context: context);
          });
        } else if (state is ErrorAuthState) {
          AwesomeDialogMessage()
              .showErrorAwesomeDialog(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return _formWidget(
            width: width,
            context: context,
            emailController: _emailController,
            passwordController: _passwordController,
            emailFocusNode: _emailFocusNode,
            passwordFocusNode: _passwordFocusNode,
            formKey: _formKey);
      },
    );
  }

  Widget _formWidget(
      {required BuildContext context,
      required TextEditingController emailController,
      required TextEditingController passwordController,
      required FocusNode emailFocusNode,
      required FocusNode passwordFocusNode,
      required GlobalKey<FormState> formKey,
      required double width}) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          // Logo
          LogoWidget(
            title: 'Sign In As Passenger',
            width: width,
          ),
          SizedBox(height: widget.height * 0.05),
          CustomTextFormField(
            focusNode: _emailFocusNode,
            onSave: (value) {},
            controller: emailController,
            isPasswordField: false,
            text: 'Email',
            hint: 'example@gmail.com',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email Can\'t be Empty';
              } else if (value.length > 100) {
                return 'Too Long Email';
              }
            },
          ),
          SizedBox(height: widget.height * 0.02),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ShowPasswordState) {
                widget.isPasswordVisible = state.isPasswordVisible;
              } else if (state is HidePasswordState) {
                widget.isPasswordVisible = state.isPasswordVisible;
              }
            },
            builder: (context, state) {
              return CustomTextFormField(
                onSave: (value) {},
                controller: passwordController,
                toggelPasswordFunction: () {
                  BlocProvider.of<AuthCubit>(context).toggelPassword();
                },
                isPasswordVisible: widget.isPasswordVisible,
                isPasswordField: true,
                focusNode: _passwordFocusNode,
                text: 'Password',
                hint: '* * * * * * ',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password Can\'t be Empty';
                  }
                },
              );
            },
          ),
          SizedBox(height: widget.height * 0.05),
          CustomButton(
            onPress: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();

                final authEntity = AuthModel(
                    email: emailController.text,
                    password: passwordController.text);

                BlocProvider.of<AuthCubit>(context)
                    .emailAndPasswordLogIn(authEntity: authEntity);
              }
            },
            text: 'SIGN IN',
          ),
          SizedBox(height: widget.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Don\'t have an account, ',
                alignment: Alignment.center,
                fontFamily: 'Ubuntu-Light',
                fontSize: 13,
              ),
              SizedBox(width: widget.width * 0.03),
              InkWell(
                onTap: () {
                  AnimatedNavigation()
                      .navigate(widget: const SignUpView(), context: context);
                },
                child: const CustomText(
                  text: 'sign up here',
                  color: Colors.blue,
                  alignment: Alignment.center,
                  fontFamily: 'Ubuntu-Medium',
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: widget.height * 0.02),
          const CustomText(
            text: '-OR-',
            alignment: Alignment.center,
            fontSize: 14,
          ),
          SizedBox(height: widget.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonLogo(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).googleLogIn();
                },
                imageName: 'assets/images/google.png',
              ),
              CustomButtonLogo(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).faceBookLogIn();
                },
                imageName: 'assets/images/facebook.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
