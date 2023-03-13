import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/screens/shared/splash/splash_screen.dart';
import 'package:outq/screens/shared/update_check/update_dialog.dart';

class UpdateHome extends StatefulWidget {
  const UpdateHome({Key? key}) : super(key: key);

  @override
  State<UpdateHome> createState() => _UpdateHomeState();
}

class _UpdateHomeState extends State<UpdateHome> {
  @override
  void initState() {
    final newVersion = NewVersion(
      androidId: 'in.outq.app',
    );

    Timer(const Duration(milliseconds: 2000), () {
      checkNewVersion(newVersion);
    });

    super.initState();
  }

  void checkNewVersion(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      if (status.canUpdate) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(
              allowDismissal: true,
              description: status.releaseNotes!,
              version: status.storeVersion,
              appLink: status.appStoreLink,
            );
          },
        );
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogText:
              'New Version is available in the store (${status.storeVersion}), update now!',
          dialogTitle: 'Update is Available!',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreen());
  }
}
