import 'package:url_launcher/url_launcher.dart';

class IntentUtils {
  static Future<bool> openBrowserURL({
    required String url,
    bool inApp = false,
  }) async {
    final uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      return false;
    }

    final launchMode =
        inApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication;

    return await launchUrl(
      uri,
      mode: launchMode,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
      ),
    );
  }
}
