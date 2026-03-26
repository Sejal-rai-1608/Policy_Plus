import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://policyplus-backend.onrender.com";

  // =========================
  // 📊 PLANS
  // =========================
  static Future<List> getPlans() async {
    final response = await http.get(Uri.parse("$baseUrl/plans"));

    print("PLANS STATUS: ${response.statusCode}");
    print("PLANS BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load plans");
    }
  }

  // =========================
  // 📄 POLICIES
  // =========================
  static Future<List> getPolicies() async {
    final response = await http.get(Uri.parse("$baseUrl/policies"));

    print("POLICY STATUS: ${response.statusCode}");
    print("POLICY BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load policies");
    }
  }

  // =========================
  // 🏦 BANK
  // =========================
  static Future<void> addBankDetails(Map data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/bank"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    print("BANK STATUS: ${response.statusCode}");
    print("BANK BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Bank save failed");
    }
  }

  // =========================
  // 📄 CLAIM
  // =========================
  static Future<void> addClaim(Map data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/claim"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    print("CLAIM STATUS: ${response.statusCode}");
    print("CLAIM BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Claim submit failed");
    }
  }
}