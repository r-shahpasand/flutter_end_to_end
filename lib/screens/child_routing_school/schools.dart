import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_latest/bloc/school/school_bloc.dart';
import 'package:sample_latest/data/models/school/school_model.dart';
import 'package:sample_latest/extensions/widget_extension.dart';
import 'package:sample_latest/mixins/dialogs.dart';
import 'package:sample_latest/mixins/helper_widgets_mixin.dart';
import 'package:sample_latest/mixins/loaders.dart';
import 'package:sample_latest/screens/child_routing_school/create_school.dart';
import 'package:sample_latest/screens/regular_widgets/dialogs.dart';
import 'package:sample_latest/utils/device_configurations.dart';
import 'package:sample_latest/widgets/custom_app_bar.dart';

class Schools extends StatefulWidget {
  const Schools({Key? key}) : super(key: key);

  @override
  State<Schools> createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> with Loaders, CustomDialogs, HelperWidget{
  @override
  void initState() {
      BlocProvider.of<SchoolBloc>(context).add(SchoolsDataEvent());
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => ScaffoldMessenger.of(context).showSnackBar(snackbar));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Schools'),
        appBar: AppBar(),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: onTapOfCreateSchool, label: Text('Create School'), icon: Icon(Icons.add)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Registered Schools:', style: Theme.of(context).textTheme.titleMedium)],
          ),
          Expanded(child: _buildSchoolBlocConsumer()),
        ],
      ).screenPadding(),
    );
  }

  Widget _buildSchoolBlocConsumer() {
    return BlocConsumer<SchoolBloc, SchoolState>(
        listener: (context, state) {
        },
        // listenWhen: (context, state) {
        //   return state is SchoolsInfoLoaded && state is List<SchoolModel>;
        // },

        buildWhen: (context, state) {
          return state.schoolStateType == SchoolDataLoadedType.schools;
        },
        builder: (context, state) {
          if (state is SchoolInfoInitial || state is SchoolInfoLoading) {
            return circularLoader();
          } else if (state is SchoolsInfoLoaded) {
            return _buildRegisteredSchools(state.schools);
          } else {
            return Container();
          }
        });
  }

  Widget _buildRegisteredSchools(List<SchoolModel> schools) {

    if(schools.isEmpty) return emptyMessage('No Schools Found, Create a new School');

    return  SizedBox(
      width: DeviceConfiguration.isMobileResolution ? null : MediaQuery.of(context).size.width/3,
      child: ListView.separated(
          itemCount: schools.length,
          itemBuilder: (context, index) {
            var school = schools.elementAt(index);
            return ListTile(
              leading: const Icon(Icons.school),
              title: Text(school.schoolName),
              subtitle: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children:[
                      const TextSpan(text: 'Country :', style: TextStyle(color: Colors.orange)),
                      TextSpan(text:  school.country),
                    ]
                  )),
              trailing:Wrap(
                children: [
                  IconButton(icon : const Icon(Icons.edit, color: Colors.blue), onPressed: () => onTapOfEditSchool(school)),
                  IconButton(icon : const Icon(Icons.delete, color: Colors.red), onPressed: () => onTapOfSchoolDelete(school.schoolId))
                ],
              ),
              onTap: () => onTapOfSchool(school),
            );
          }, separatorBuilder: (BuildContext context, int index) => Divider()),
    );
  }

  SnackBar get snackbar => const SnackBar(content: Text("Integrated the API's using Firebase Realtime Data base !!!"));

  onTapOfSchool(SchoolModel school) {
    var query = school.toJson();
    query['schoolId'] = query['schoolId'].toString();
    context.go(Uri(path: '/home/schools/schoolDetails', queryParameters: query).toString(), extra: (school, null));
  }

  onTapOfCreateSchool() {
    adaptiveDialog(context, const CreateSchool());
  }

  onTapOfEditSchool(SchoolModel school) {
    adaptiveDialog(context, CreateSchool(school: school));
  }

  onTapOfSchoolDelete(int schoolId) {
    BlocProvider.of<SchoolBloc>(context).add(DeleteSchoolEvent(schoolId));
  }

}
