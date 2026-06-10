import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../API/supabase_api.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  bool _obscurePassword = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
    _emailFocus.addListener(() => setState(() {}));
    _firstNameFocus.addListener(() => setState(() {}));
    _lastNameFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    _emailFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    final email = _usernameController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor preencha todos os campos.')),
      );
      return;
    }

    try {
      await SupabaseApi.login(
        email: email,
        password: password,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
      Navigator.pushReplacementNamed(context, '/');
    } catch (error) {
      if (!mounted) return;
      final message = error.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login: $message')),
      );
    }
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if (email.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor preencha todos os campos.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As passwords não coincidem.')),
      );
      return;
    }

    try {
      await SupabaseApi.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso. Verifique o seu email.'),
        ),
      );
      setState(() {
        _isLogin = true;
      });
    } catch (error) {
      if (!mounted) return;
      final message = error.toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao criar conta: $message')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 48,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Brand Identity
                        Column(
                          children: [
                            Text(
                              'GarageHUB',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.primaryContainer,
                                letterSpacing: -0.02,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'High-Performance Marketplace',
                              style:
                                  GoogleFonts.manrope(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.onSurfaceVariant,
                                    letterSpacing: 0.2,
                                  ).copyWith(
                                    fontFeatures: [
                                      const FontFeature.enable('smcp'),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        // Card UI
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 420),
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.outlineVariant.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to the Garage',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _isLogin
                                    ? 'Sign in to your account or create a new profile to explore our inventory.'
                                    : 'Create a new account to join our marketplace.',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Form
                              Form(
                                child: Column(
                                  children: [
                                    if (!_isLogin) ...[
                                      // First Name
                                      _buildInputField(
                                        label: 'First Name',
                                        controller: _firstNameController,
                                        placeholder: 'e.g. John',
                                        focusNode: _firstNameFocus,
                                      ),
                                      const SizedBox(height: 24),
                                      // Last Name
                                      _buildInputField(
                                        label: 'Last Name',
                                        controller: _lastNameController,
                                        placeholder: 'e.g. Doe',
                                        focusNode: _lastNameFocus,
                                      ),
                                      const SizedBox(height: 24),
                                      // Email for sign up
                                      _buildInputField(
                                        label: 'Email',
                                        controller: _emailController,
                                        placeholder: 'e.g. driver@example.com',
                                        focusNode: _emailFocus,
                                      ),
                                      const SizedBox(height: 24),
                                    ] else ...[
                                      // Username or Email (login)
                                      _buildInputField(
                                        label: 'Username or Email',
                                        controller: _usernameController,
                                        placeholder: 'e.g. driver_01',
                                        focusNode: _usernameFocus,
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                    // Password
                                    _buildPasswordField(),
                                    if (!_isLogin) ...[
                                      const SizedBox(height: 24),
                                      // Confirm Password
                                      _buildInputField(
                                        label: 'Confirm Password',
                                        controller: _confirmPasswordController,
                                        placeholder: '••••••••',
                                        obscureText: true,
                                        focusNode: _confirmPasswordFocus,
                                      ),
                                    ],
                                    const SizedBox(height: 32),
                                    // Submit Button
                                    SizedBox(
                                      width: double.infinity,
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed: _isLogin ? _login : _signUp,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              9999,
                                            ),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                AppTheme.primaryContainer,
                                                AppTheme.primaryFixedDim,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              9999,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.primaryContainer
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            _isLogin
                                                ? 'LOGIN'
                                                : 'CREATE ACCOUNT',
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color:
                                                  AppTheme.onPrimaryContainer,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              // Alternate Actions
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: AppTheme.outlineVariant
                                              .withOpacity(0.2),
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          _isLogin
                                              ? 'New to the platform?'
                                              : 'Already have an account?',
                                          style:
                                              GoogleFonts.manrope(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    AppTheme.onSurfaceVariant,
                                                letterSpacing: 0.2,
                                              ).copyWith(
                                                fontFeatures: [
                                                  const FontFeature.enable(
                                                    'smcp',
                                                  ),
                                                ],
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: AppTheme.outlineVariant
                                              .withOpacity(0.2),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: OutlinedButton(
                                      onPressed: _toggleMode,
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppTheme.outlineVariant
                                              .withOpacity(0.3),
                                          width: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            9999,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        _isLogin ? 'Create Account' : 'Sign In',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.onSurface,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),
                        // Footer Meta
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildFooterLink('Terms'),
                            const SizedBox(width: 24),
                            _buildFooterLink('Privacy'),
                            const SizedBox(width: 24),
                            _buildFooterLink('Support'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom Navigation Bar
                CustomBottomNavBar(
                  selectedIndex: -1,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        Navigator.pushReplacementNamed(context, '/');
                        break;
                      case 1:
                        Navigator.pushReplacementNamed(
                          context,
                          '/search_filters',
                        );
                        break;
                      case 2:
                        Navigator.pushReplacementNamed(
                          context,
                          '/create_listing',
                        );
                        break;
                      case 3:
                        Navigator.pushReplacementNamed(context, '/messages');
                        break;
                      case 4:
                        Navigator.pushReplacementNamed(context, '/saved');
                        break;
                    }
                    setState(() {
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    bool obscureText = false,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSecondaryFixedVariant,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                obscureText: obscureText,
                style: TextStyle(color: AppTheme.onSurface),
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: TextStyle(
                    color: AppTheme.outline.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 2,
                width: (focusNode?.hasFocus ?? false) ? double.infinity : 0,
                color: AppTheme.primaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                'Password'.toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSecondaryFixedVariant,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            if (_isLogin)
              GestureDetector(
                onTap: () {
                  // TODO: Implement forgot password
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Forgot password not implemented'),
                    ),
                  );
                },
                child: Text(
                  'Forgot Password?'.toUpperCase(),
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryFixedDim,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: _obscurePassword,
                style: TextStyle(color: AppTheme.onSurface),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: TextStyle(
                    color: AppTheme.outline.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppTheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 2,
                width: _passwordFocus.hasFocus ? double.infinity : 0,
                color: AppTheme.primaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement links
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$text not implemented')));
      },
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.manrope(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppTheme.onSurfaceVariant.withOpacity(0.4),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool isSpecial;

  _NavItem({required this.icon, required this.label, this.isSpecial = false});
}
