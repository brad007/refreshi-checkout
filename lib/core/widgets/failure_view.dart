import 'package:flutter/material.dart';

import '../error/failures.dart';
import '../theme/app_theme.dart';
import 'brand.dart';

class FailureView extends StatelessWidget {
  const FailureView({super.key, required this.failure, this.onRetry, this.action});

  final Failure failure;
  final VoidCallback? onRetry;
  final Widget? action;

  /// Retrying only helps with transient failures; a missing order or a bad
  /// request won't change on a second attempt.
  bool get _retryable => switch (failure) {
    NetworkFailure() || ServerFailure() || CacheFailure() => true,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showRetry = onRetry != null && _retryable;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                failure is NotFoundFailure ? Icons.search_off_rounded : Icons.error_outline_rounded,
                size: 48,
                color: RefreshiColors.orangeInk,
              ),
              const SizedBox(height: 16),
              Text(
                failure.userMessage,
                textAlign: TextAlign.center,
                style: displayStyle(24, color: theme.colorScheme.onSurface, height: 1.1),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (showRetry) FilledButton(onPressed: onRetry, child: const Text('Try again')),
                  ?action,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
