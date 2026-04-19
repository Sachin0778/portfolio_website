import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'depth_panel.dart';
import 'section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.paddingXLarge.h),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        return Column(
          children: [
            const SectionHeader(
              eyebrow: 'Contact',
              title: 'Let\'s build something great',
              subtitle:
                  'Tell me about your idea — I typically reply within one business day.',
            ),
            SizedBox(height: 28.h),

            // Contact Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: DepthPanel(
                    padding: EdgeInsets.all(AppConstants.paddingLarge.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Let\'s work together',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                            color: AppConstants.textPrimary,
                          ),
                        ).animate().fadeIn(delay: 400.ms).slideX(),

                        SizedBox(height: 12.h),

                        Text(
                          'I\'m always interested in new opportunities and exciting projects. Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppConstants.textSecondary,
                            height: 1.5,
                          ),
                        ).animate().fadeIn(delay: 600.ms).slideX(),

                        SizedBox(height: 20.h),

                        _ContactMethod(
                        icon: Icons.email,
                        title: 'Email',
                        subtitle: portfolioData.email,
                        onTap: () async {
                          final email = portfolioData.email;
                          final uri = 'mailto:$email';
                          final ok = await launchUrlString(uri);
                          if (!ok) {
                            Get.snackbar('Failed', 'Could not open email client');
                          }
                        },
                      ).animate().fadeIn(delay: 800.ms).slideX(),

                      _ContactMethod(
                        icon: Icons.phone,
                        title: 'Phone',
                        subtitle: portfolioData.phone,
                        onTap: () async {
                          final phone = portfolioData.phone.replaceAll(' ', '');
                          final uri = 'tel:$phone';
                          final ok = await launchUrlString(uri);
                          if (!ok) {
                            Get.snackbar('Failed', 'Could not open phone dialer');
                          }
                        },
                      ).animate().fadeIn(delay: 1000.ms).slideX(),

                      _ContactMethod(
                        icon: Icons.location_on,
                        title: 'Location',
                        subtitle: portfolioData.location,
                        onTap: () async {
                          final query = Uri.encodeComponent(portfolioData.location);
                          final url = 'https://www.google.com/maps/search/?api=1&query=$query';
                          final ok = await launchUrlString(url, mode: LaunchMode.externalApplication);
                          if (!ok) {
                            Get.snackbar('Failed', 'Could not open maps');
                          }
                        },
                      ).animate().fadeIn(delay: 1200.ms).slideX(),

                      SizedBox(height: 20.h),

                      // Social Links
                      Text(
                        'Follow Me',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.textPrimary,
                        ),
                      ).animate().fadeIn(delay: 1400.ms).slideX(),

                      SizedBox(height: 12.h),

                      Row(
                        children: portfolioData.socialLinks.map((link) {
                          return Container(
                            margin: EdgeInsets.only(right: 16.w),
                            child: IconButton(
                              onPressed: () async {
                                final url = link.url;
                                if (url.isEmpty) {
                                  Get.snackbar('Unavailable', 'No URL configured for ${link.platform}');
                                  return;
                                }
                                final ok = await launchUrlString(url, mode: LaunchMode.externalApplication);
                                if (!ok) {
                                  Get.snackbar('Failed', 'Could not open ${link.platform}');
                                }
                              },
                              icon: FaIcon(
                                _getSocialIcon(link.platform),
                                color: AppConstants.textSecondary,
                                size: 24.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ).animate().fadeIn(delay: 1600.ms).slideY(),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 48.w),

                // Right Side - Contact Form
                if (MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint)
                  Expanded(
                    flex: 1,
                    child: _ContactForm(),
                  ),
              ],
            ),

            // Mobile Contact Form
            if (MediaQuery.of(context).size.width <= AppConstants.tabletBreakpoint) ...[
              SizedBox(height: 24.h),
              _ContactForm(),
            ],
          ],
        );
      }),
    );
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'github':
        return FontAwesomeIcons.github;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'email':
        return FontAwesomeIcons.envelope;
      case 'medium':
        return FontAwesomeIcons.medium;
      default:
        return FontAwesomeIcons.link;
    }
  }
}

class _ContactMethod extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: DepthPanel(
          borderRadius: AppConstants.radiusMedium,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final iconSize = (w * 0.2).clamp(34.0, 44.0);
              final gap = (w * 0.035).clamp(6.0, 12.0);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      gradient: AppConstants.primaryGradient,
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    ),
                    child: Icon(
                      icon,
                      color: AppConstants.textPrimary,
                      size: (iconSize * 0.48).clamp(16.0, 22.0),
                    ),
                  ),
                  SizedBox(width: gap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: (w * 0.055).clamp(12.0, 14.0),
                            fontWeight: FontWeight.w600,
                            color: AppConstants.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: (w * 0.048).clamp(10.5, 12.0),
                            color: AppConstants.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DepthPanel(
      padding: EdgeInsets.all(AppConstants.paddingLarge.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Message',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppConstants.textPrimary,
              ),
            ).animate().fadeIn(delay: 1800.ms).slideX(),

            SizedBox(height: 24.h),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Your full name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                  borderSide: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ).animate().fadeIn(delay: 2000.ms).slideX(),

            SizedBox(height: 16.h),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'your.email@example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                  borderSide: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ).animate().fadeIn(delay: 2200.ms).slideX(),

            SizedBox(height: 16.h),

            // Subject Field
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                hintText: 'What\'s this about?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                  borderSide: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ).animate().fadeIn(delay: 2400.ms).slideX(),

            SizedBox(height: 16.h),

            // Message Field
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                hintText: 'Tell me about your project...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                  borderSide: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
            ).animate().fadeIn(delay: 2600.ms).slideX(),

            SizedBox(height: 24.h),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  'Send Message',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 2800.ms).scale(),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        'Message Sent!',
        'Thank you for your message. I\'ll get back to you soon!',
        backgroundColor: AppConstants.primaryColor,
        colorText: AppConstants.textPrimary,
        snackPosition: SnackPosition.TOP,
      );
      
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }
}
