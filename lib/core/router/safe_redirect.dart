/// Only allow in-app paths as post-sign-in destinations, so a crafted link
/// like `/sign-in?redirect=https://evil.example` can't bounce users off-site.
String safeRedirectPath(String? redirect, {String fallback = '/'}) {
  if (redirect == null || redirect.isEmpty) return fallback;
  final uri = Uri.tryParse(redirect);
  if (uri == null || uri.hasScheme || uri.hasAuthority) return fallback;
  if (!redirect.startsWith('/') || redirect.startsWith('//')) return fallback;
  if (uri.path == '/sign-in') return fallback;
  return redirect;
}
