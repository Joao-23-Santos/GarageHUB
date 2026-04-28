import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/conversation_item.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex = 3; // Messages tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation here
    switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/search_filters');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/create_listing');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/messages');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/saved');
              break;
          }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppTheme.primaryContainer),
          onPressed: () {},
        ),
        title: Text(
          'Messages',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppTheme.primaryContainer,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppTheme.primaryContainer),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Search Section
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search conversations...',
                  hintStyle: GoogleFonts.manrope(
                    color: AppTheme.outline,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppTheme.outline,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                style: GoogleFonts.manrope(
                  color: AppTheme.onSurface,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Conversations List
            Expanded(
              child: ListView(
                children: [
                  ConversationItem(
                    name: 'João Silva',
                    time: '2m ago',
                    carModel: 'Porsche 911 GT3',
                    message: 'Is the price negotiable?',
                    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAEzxaTLos3X8TVXWD41t72FcLaIKKS5TPghPFgliBxSQHlXwsQW0Khh8s8LZ1809A0_7dfbUek9o2gzmsNct3Po47FOlEsYbTZTAG4Op-pTdV6nQeMBzHjEO5q8jz539VSAIaIdJ47QPTUwWXRUugmU3EOZ3-P9mpKwk5xXNizDSProvHhN_tTNPnCroqwksWsC-e0Mkllh2HfreDw0K3GEZ8X5kcuuJqjZ6tSOZuMcMq10kzv9_vBkqJbpNoSaiHbikaNgQkJqBA',
                    carImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDMz_f8sTP_1kNGHYzRUocL5rWWhYZ58osPHosmG_aY4BLbhJRRNNxruPPZCgkXIYi5_-DTi33-uIe0uvX_GWPHP-OHk0jCEoHKytYNkGua_73E0JPkAe5YZyUdbesgNPpZWNMw2QqAoiVdIrRnRezypk32tYggejY6TRYyZO5SEcbokUrC7Q7mgSTbubxoK3xw2-RR-41QGZzFV1FKKGexlEF880hVacI5W9TDdDyFdurJp8bjHBZNfxcif3c1u6hrAsIGrB-jB_g',
                    isUnread: true,
                  ),
                  ConversationItem(
                    name: 'Maria Santos',
                    time: 'Yesterday',
                    carModel: 'BMW M4',
                    message: 'I sent the documents.',
                    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDuicVIKvGKgR6Q6O7rQwTb62WWnxuN3iIf_swCMWccXYMQoQZCQU2DPxNRNVQq8k1tKxm4AtpJ47FJJAv5RZxyk520YHSgVnnNyOZhTccaLCh7RfAXoIOc4RzmRHvau5YzjjEntdvLygfPKKN8WFLhFw938dowXFCMwiie1mgnRZLNO44DIQsCk6wlfp5FIlqbKC26vue05X0HXxKMt8hKqBdvssy-3x2_aFEQM58ZCN55ipv1SNgY3ZrC4BkoMK6CC_FdCLviLVg',
                    carImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCEJy1UqrujEEskNPRrK2Bz780k9lijzKTh8VMkCEh7K6WhhUWf14MO8Gzsyc0JC-nbb9NhUnrYHAh6_QLhNg6IZQOFGlDI4O2DkinXw4XVj_0LgSxM9Q5hbyZnapU99xvqTOlLEkUKY4rdHPz3KdnGGegT1V72Mt5rRZmkH1TiTBaHTA5gRPKNxyLQQF6M5n9bqEipJqgjxRiEj8EuyzJKt_LZIXfMKItCyB9QkFrLDW9UTX4q-nBp45-1HgUfq7lKwBJ_k0WsUsc',
                    isUnread: false,
                  ),
                  ConversationItem(
                    name: 'Ricardo Alves',
                    time: 'Tue',
                    carModel: 'Tesla Model S',
                    message: 'When can I see the car?',
                    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD5TeDNLZpxEzZHA9psh61V97cNqdFx8PnLuFrvVyVKYSe26ZjaJLLzhOQtl9SCYhbioq7yJpIzZE66B8dFoKi9fsb_bsK8qysJ4nOYuIQn2hvgZuIeqaBnxWUXFEqdVBvnFTQEwx40to9k6Grgo-44vL7jgyS1HyisYvvTE2f1C8WMVLUWuob7PQxit3jndZC-8g7yjbk_RsXumJ5rwZpgO2BZSdJ6i8vBrXaxgGNdOV0vMFP2G-XTRXq8Xch-e8MQ_Tlqaa5I2FU',
                    carImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAa17PBhc-rdIhURpEMagiQN-pJzpgumTL1py7Etrn7YaxSkOhK_fTUeij6EYiPih1-lFApTIA969Il_UvuDd3ZoPsvy01-Lis5ZhZKLfdTg51mAq1HACtu4ME46zAISbsX5bLDkXPnaI1dxcmrrprn48RpEenPI-7fOeQt9ly4x3BD0qWzYMM-CGY_icZpOmJKqwIrh7LS9PeGwSfU_w1qGWnfyb-nS-hOCvTL-EYxmStfAFYOaYjYxV1efVkbYKbG2-eT94gc2WE',
                    isUnread: false,
                  ),
                  // Empty state
                  SizedBox(height: 48),
                  Center(
                    child: Opacity(
                      opacity: 0.2,
                      child: Column(
                        children: [
                          Icon(
                            Icons.forum,
                            size: 96,
                            color: AppTheme.onSurface,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'End of Archive',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              color: AppTheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: AppTheme.onPrimaryContainer,
        child: Icon(Icons.edit_square),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}