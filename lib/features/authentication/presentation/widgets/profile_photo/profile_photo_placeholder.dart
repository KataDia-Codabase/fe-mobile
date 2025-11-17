import 'package:flutter/material.dart';

class ProfilePhotoPlaceholder extends StatelessWidget {
  const ProfilePhotoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFE3EBFF),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF2F6BFF),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 80,
            color: Color(0xFF2F6BFF),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF2F6BFF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2F6BFF).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
