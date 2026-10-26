import 'dart:math' as math;
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../router/app_router.gr.dart';
import '../theme/app_theme.dart';

/// Shared page chrome: a floating, frosted pill nav bar (as on
/// refreshi.co.za) and a centred, width-constrained body.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.title, required this.body, this.bottomBar, this.maxWidth = 1040});

  static const compactBreakpoint = 720.0;
  static const _navHeight = 64.0;

  final String title;
  final Widget body;
  final Widget? bottomBar;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Title(
      title: '$title · Refreshi',
      color: RefreshiColors.forest,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(_navHeight + 16),
          // Fixed-height chrome: cap text scaling so it can't overflow.
          child: MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3, child: const _PillNavBar()),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: body,
          ),
        ),
        bottomNavigationBar: bottomBar,
      ),
    );
  }
}

class _PillNavBar extends StatelessWidget {
  const _PillNavBar();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  height: AppShell._navHeight,
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
                  ),
                  child: Row(
                    children: [
                      Semantics(
                        button: true,
                        label: 'Refreshi home',
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () => context.router.navigate(const CatalogRoute()),
                          // The wordmark is a logo, so it doesn't scale with text.
                          child: MediaQuery.withNoTextScaling(child: const RefreshiLogo()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Align(alignment: Alignment.centerRight, child: _SessionActions()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wordmark in the style of the brand: a bold "C"-shaped mark and a
/// lower-case name.
class RefreshiLogo extends StatelessWidget {
  const RefreshiLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(size: const Size.square(26), painter: _MarkPainter(color)),
        const SizedBox(width: 6),
        Text(
          'refreshi',
          style: TextStyle(
            fontFamily: RefreshiFonts.display,
            fontFamilyFallback: RefreshiFonts.fallback,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: -0.6,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()..color = color;
    // A disc with a wedge cut out on the right: the brand's "C" mark.
    canvas.drawArc(rect, math.pi / 5, 2 * math.pi - 2 * math.pi / 5, true, paint);
  }

  @override
  bool shouldRepaint(_MarkPainter oldDelegate) => oldDelegate.color != color;
}

class _SessionActions extends StatelessWidget {
  const _SessionActions();

  void _signOut(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEvent.signOutRequested());
    context.router.replaceAll([const CatalogRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final session = state.session;
        if (session == null) {
          if (state.status == AuthStatus.unknown || context.router.currentPath == '/sign-in') {
            return const SizedBox.shrink();
          }
          // Signed out: offer sign-in, coming back to this page afterwards.
          return OutlinedButton(
            onPressed: () => context.router.push(SignInRoute(redirect: context.router.currentUrl)),
            child: const Text('Sign in'),
          );
        }
        final compact = MediaQuery.sizeOf(context).width < AppShell.compactBreakpoint;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!compact)
              Flexible(
                child: Text(
                  session.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            const SizedBox(width: 12),
            if (compact)
              IconButton(
                tooltip: 'Sign out',
                onPressed: () => _signOut(context),
                icon: const Icon(Icons.logout_rounded),
              )
            else
              OutlinedButton(onPressed: () => _signOut(context), child: const Text('Sign out')),
          ],
        );
      },
    );
  }
}
