import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';

class ProjectService {
  static const String baseUrl = 'https://dev.surahapp.com/api/v1';

  Future<List<Project>> getAllProjects() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/projects'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Project.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load projects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }

  Future<List<Project>> getProjectsByType(String type) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/projects/$type'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Project.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load projects by type: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching projects by type: $e');
    }
  }

  Future<Project> getProjectBySlug(String slug) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/project/$slug'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Project.fromJson(jsonData);
      } else {
        throw Exception('Failed to load project: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching project: $e');
    }
  }
} 