import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../API/supabase_api.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _dobController = TextEditingController();
  String _avatarUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBgrsOW_JrjTDDavMJtLMN66ZxXTea8wAl7MlmuEq8l8WmM94iToKmMyNwXZ1P5FFFncTCtdrj2UIc4lQ540bFIchk29oOnWGUBnlULSVmgUjXcrMYwlB7FERjgMSzoSVjr8HjxDvacSXrksFHaEhpALB2Yw_37lggtpZYIOgzl2qbQYjxxP5XAb7jEM6J0gqJZFQolBuDgo7y3t6Xoci6IiJkbJsOZo7sYWwlA7fmekiE_Bf2z8C_7sNcrJtdbY6xDgBg6zgGXYnw';

  bool _showToast = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _locationController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = SupabaseApi.getCurrentUser();
    if (user == null) {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final profile = await SupabaseApi.fetchProfile(user.id);
    if (profile == null) return;

    setState(() {
      final fullName = (profile['full_name'] ?? '').toString().trim();
      if (fullName.isNotEmpty) {
        final parts = fullName.split(RegExp(r"\s+"));
        _firstNameController.text = parts.first;
        _lastNameController.text = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      } else {
        _firstNameController.text = (profile['first_name'] ?? '').toString();
        _lastNameController.text = (profile['last_name'] ?? '').toString();
      }
      _locationController.text = (profile['location'] ?? '').toString();
      _dobController.text = (profile['date_of_birth'] ?? profile['dob'] ?? '').toString();
      _avatarUrl = (profile['avatar_url'] ?? profile['avatar'] ?? _avatarUrl).toString();
    });
  }

  void _onSave() async {
    // TODO: wire to backend if desired. For now show success toast.
    setState(() => _showToast = true);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    setState(() => _showToast = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      // Top bar visually matches the provided HTML (close + title)
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Top app bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface.withOpacity(0.8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.close, color: AppTheme.primaryContainer),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'EDIT PROFILE',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Avatar
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.primaryContainer, width: 4),
                              color: AppTheme.surfaceContainerLow,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                _avatarUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Icon(Icons.person, size: 48, color: AppTheme.onSurfaceVariant),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.black.withOpacity(0.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(9999),
                                onTap: () {
                                  // TODO: allow picking new avatar
                                },
                                child: Container(),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryContainer,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppTheme.surface, width: 2),
                              ),
                              child: const Icon(Icons.edit, color: AppTheme.onPrimaryContainer, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Form
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildLabeledField('First Name', _firstNameController),
                        const SizedBox(height: 24),
                        _buildLabeledField('Last Name', _lastNameController),
                        const SizedBox(height: 24),
                        _buildIconField('Location', Icons.location_on, _locationController),
                        const SizedBox(height: 24),
                        _buildIconField('Date of Birth', Icons.calendar_today, _dobController, placeholder: 'DD/MM/YYYY'),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryContainer,
                              foregroundColor: AppTheme.onPrimaryContainer,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'SAVE CHANGES',
                              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w900, letterSpacing: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Success toast
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showToast ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: !_showToast,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20)],
                      ),
                      child: Text(
                        'Profile Updated Successfully'.toUpperCase(),
                        style: GoogleFonts.spaceGrotesk(
                          color: AppTheme.onPrimaryContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: -1, onTap: (index) {}),
    );
  }

  Widget _buildLabeledField(String label, TextEditingController controller) {
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
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: AppTheme.onSurface),
            decoration: InputDecoration(
              hintText: 'Enter $label'.toLowerCase(),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconField(String label, IconData icon, TextEditingController controller, {String? placeholder}) {
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
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, color: AppTheme.primaryContainer.withOpacity(0.6)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: AppTheme.onSurface),
                  decoration: InputDecoration(
                    hintText: placeholder ?? '',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
