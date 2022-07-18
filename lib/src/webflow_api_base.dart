// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

class Webflow {
  String endpoint;
  String token;
  String version;
  String siteId;
  Map<String, String>? headers;

  Webflow({
    required this.token,
    required this.siteId,
    this.version = "1.0.0",
    this.endpoint = "api.webflow.com",
  }) {
    headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "accept-version": version,
      "Content-Type": "application/json",
    };
  }

}
