import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memoir/components/display/image.dart';
import 'package:memoir/models/app.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Account? account = context.watch<AppStateProvider>().account;
    return Center(
        child:
            MaybeFileImage(image: account!.image, width: 200.0, height: 200.0));
  }
}
