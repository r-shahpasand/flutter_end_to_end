// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return StudentModel(
    json['id'] as int,
    json['studentName'] as String,
    json['studentLocation'] as String,
    json['standard'] as String,
  );
}

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentName': instance.studentName,
      'studentLocation': instance.studentLocation,
      'standard': instance.standard,
    };
