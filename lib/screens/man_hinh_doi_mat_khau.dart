// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController oldPasswordCont = TextEditingController();
  final TextEditingController newPasswordCont = TextEditingController();
  final TextEditingController confirmPasswordCont = TextEditingController();

  // Focus nodes
  final FocusNode oldPassNode = FocusNode();
  final FocusNode newPasswordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  // Mock: Lưu mật khẩu cũ (thay cho SharedPreferences)
  final String savedOldPassword = "123456";

  // Loading state
  bool isLoading = false;

  // Submit logic
  void submit() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Giả lập API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully!')),
          );
          // Reset form
          oldPasswordCont.clear();
          newPasswordCont.clear();
          confirmPasswordCont.clear();
        }
      });
    }
  }

  @override
  void dispose() {
    oldPasswordCont.dispose();
    newPasswordCont.dispose();
    confirmPasswordCont.dispose();
    oldPassNode.dispose();
    newPasswordNode.dispose();
    confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thay AppScaffold → Scaffold
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  // Old Password
                  TextFormField(
                    controller: oldPasswordCont,
                    focusNode: oldPassNode,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(newPasswordNode),
                    decoration: const InputDecoration(
                      labelText: 'Old Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim() != savedOldPassword) {
                        return 'Old password is incorrect';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // New Password
                  TextFormField(
                    controller: newPasswordCont,
                    focusNode: newPasswordNode,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(
                      context,
                    ).requestFocus(confirmPasswordNode),
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Confirm Password
                  TextFormField(
                    controller: confirmPasswordCont,
                    focusNode: confirmPasswordNode,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => submit(),
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim() != newPasswordCont.text) {
                        return 'Confirm password must match new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: isLoading ? null : submit,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ).paddingAll(16),
            ),
          ),
          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            ),
        ],
      ),
    );
  }
}

// Extension để thay thế .height, .paddingAll từ nb_utils
extension WidgetExtensions on Widget {
  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }
}
