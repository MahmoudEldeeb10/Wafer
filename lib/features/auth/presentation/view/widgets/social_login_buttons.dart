import 'package:flutter/material.dart';


class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SocialButton(label: 'Google', svgAsset: 'google')),
        const SizedBox(width: 12),
        Expanded(child: _SocialButton(label: 'Github', svgAsset: 'github')),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final String svgAsset;

  const _SocialButton({required this.label, required this.svgAsset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFD0D0D0), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              svgAsset == 'google' ? Icons.g_mobiledata : Icons.code,
              size: 22,
              color: Colors.black87,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
