import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.gr.dart';
import '../../../../core/router/safe_redirect.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_shell.dart';
import '../../../../core/widgets/brand.dart';
import '../bloc/auth_bloc.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key, @QueryParam('redirect') this.redirect});

  /// Where to go after signing in. Read from the URL so it survives refresh.
  final String? redirect;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _email = TextEditingController();

  /// Hide a validation error as soon as the user edits the field again.
  bool _showError = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _showError = true);
    context.read<AuthBloc>().add(AuthEvent.signInRequested(_email.text));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => !previous.isSignedIn && current.isSignedIn,
      listener: (context, state) => context.router.replacePath(safeRedirectPath(widget.redirect)),
      child: AppShell(
        title: 'Sign in',
        maxWidth: 1040,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < AppShell.compactBreakpoint;
            final brand = ForestPanel(
              padding: EdgeInsets.all(compact ? 24 : 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  StackedHeadline(
                    size: compact ? 36 : 54,
                    lines: const [
                      ('Save food.', RefreshiColors.creamLight),
                      ('Save money.', RefreshiColors.orange),
                      ('Sign in first.', RefreshiColors.lime),
                    ],
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Your basket is saved while you sign in.',
                      style: TextStyle(color: RefreshiColors.creamLight.withValues(alpha: 0.75), fontSize: 16),
                    ),
                  ],
                ],
              ),
            );
            final form = BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) => AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome back', style: displayStyle(30)),
                    const SizedBox(height: 8),
                    Text(
                      'This is a simulated sign-in. Any email address works.',
                      style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      key: const Key('signIn.email'),
                      controller: _email,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.go,
                      onSubmitted: (_) => _submit(),
                      onChanged: (_) {
                        if (_showError) setState(() => _showError = false);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.alternate_email_rounded),
                        errorText: _showError ? state.failure?.userMessage : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      key: const Key('signIn.submit'),
                      onPressed: state.isSubmitting ? null : _submit,
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            );
            final back = BackLink(
              label: 'Back to bags',
              onPressed: () => context.router.navigate(const CatalogRoute()),
            );
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 32),
              child: Column(
                children: [
                  back,
                  const SizedBox(height: 4),
                  compact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            brand,
                            const SizedBox(height: 24),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: form),
                          ],
                        )
                      : IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: brand),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(40),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(color: theme.colorScheme.outlineVariant),
                                  ),
                                  child: Center(child: form),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
