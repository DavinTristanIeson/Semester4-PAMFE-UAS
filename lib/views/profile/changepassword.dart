import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/helpers/validators.dart';
import 'package:provider/provider.dart';
import 'package:memoir/helpers/constants.dart';
import '../../components/display/info.dart';
import '../../components/wrapper/touchable.dart';
import '../../models/app.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with SnackbarMessenger {
  final GlobalKey<FormBuilderState> _changePasswordFormKey =
      GlobalKey<FormBuilderState>();

  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmNewPasswordVisible = false;

  Future<void> _submit(BuildContext context) async {
    if (_changePasswordFormKey.currentState == null) {
      throw Exception(
          "Cannot find the change password form in the widget tree. Did you forget to put the key into the change password form?");
    }
    final state = _changePasswordFormKey.currentState!;
    if (!state.validate()) return;

    final appState = Provider.of<AppStateProvider>(context, listen: false);
    final currentPassword = state.fields['currentPassword']!.value;
    final newPassword = state.fields['newPassword']!.value;

    if (!appState.account!.changePassword(currentPassword, newPassword)) {
      sendError(context, 'Incorrect current password');
      return;
    }

    state.reset();
    sendSuccess(context, 'Password changed successfully');
    Navigator.of(context).pop();
  }

  void _togglePasswordVisibility(String fieldName) {
    setState(() {
      if (fieldName == 'currentPassword') {
        _currentPasswordVisible = !_currentPasswordVisible;
      } else if (fieldName == 'newPassword') {
        _newPasswordVisible = !_newPasswordVisible;
      } else if (fieldName == 'confirmNewPassword') {
        _confirmNewPasswordVisible = !_confirmNewPasswordVisible;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _changePasswordFormKey,
            child: Column(
              children: [
                _buildPasswordField(
                  name: 'currentPassword',
                  label: 'Current Password',
                  placeholder: 'Enter your current password',
                  visible: _currentPasswordVisible,
                  validator: validatePassword,
                ),
                _buildPasswordField(
                    name: 'newPassword',
                    label: 'New Password',
                    placeholder: 'Enter your new password',
                    visible: _newPasswordVisible,
                    validator: validatePassword),
                _buildPasswordField(
                  name: 'confirmNewPassword',
                  label: 'Confirm New Password',
                  placeholder: 'Confirm your new password',
                  visible: _confirmNewPasswordVisible,
                  validator: (String? value) {
                    if (value == null) {
                      return "Password confirmation is required";
                    } else if (_changePasswordFormKey
                            .currentState!.fields["newPassword"]!.value !=
                        value) {
                      return "Password confirmation does not match password";
                    }
                    return null;
                  },
                ),
                Container(
                  width: double.maxFinite,
                  height: 64.0,
                  padding: const EdgeInsets.only(top: GAP_LG, bottom: GAP),
                  child: ElevatedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    style: BUTTON_PRIMARY,
                    child: const Text("Change Password"),
                  ),
                ),
                Row(
                  children: [
                    const Text("Cancel?", style: TEXT_DETAIL),
                    TextLink(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: "Go back",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String name,
    required String label,
    required String placeholder,
    required bool visible,
    required String? Function(String?) validator,
  }) {
    return FormBuilderTextField(
      name: name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !visible,
      autofocus: false,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        suffixIcon: IconButton(
          icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            _togglePasswordVisibility(name);
          },
        ),
      ),
      validator: validator,
    );
  }
}
