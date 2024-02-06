part of 'school_bloc.dart';

enum SchoolDataLoadedType {schools, school, students, student}

abstract class SchoolState extends Equatable{

  final SchoolDataLoadedType schoolStateType;

  const SchoolState(this.schoolStateType);
}


class SchoolInfoInitial extends SchoolState {

  SchoolInfoInitial(super.schoolStateType);

  @override
  List<Object?> get props => [];

}

class SchoolInfoLoading extends SchoolState {

  SchoolInfoLoading(super.schoolStateType);

  @override
  List<Object?> get props => [];

}

class SchoolsInfoLoaded extends SchoolState {

   final List<SchoolModel> schools;

   SchoolsInfoLoaded(SchoolDataLoadedType schoolStateType, this.schools) : super(schoolStateType);

  @override
  List<Object?> get props => [super.schoolStateType];
}

class SchoolInfoLoaded extends SchoolState {

  final SchoolDetailsModel school;

  SchoolInfoLoaded(super.schoolStateType, this.school);

  @override
  // TODO: implement props
  List<Object?> get props => [super.schoolStateType, school];
}

class StudentInfoLoaded extends SchoolState {

  final StudentModel student;

  final SchoolDetailsModel school;

  StudentInfoLoaded(super.schoolStateType, this.student, this.school);

  @override
  // TODO: implement props
  List<Object?> get props => [super.schoolStateType, student, school];
}

class StudentsInfoLoaded extends SchoolState {

  final List<StudentModel> students;

  final SchoolDetailsModel school;

  StudentsInfoLoaded(super.schoolStateType, this.students, this.school);

  @override
  // TODO: implement props
  List<Object?> get props => [super.schoolStateType, students, school];
}

class DataError extends SchoolState {

  DataError(super.schoolStateType);

  @override
  List<Object?> get props => [];

}




