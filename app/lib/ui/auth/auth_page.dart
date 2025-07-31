import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/auth.dart';
import 'components/components.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends BasePageState<AuthPage, AuthBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return CommonScaffold(
      appBar: CommonAppBar(height: 0),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: UiConstants.commonP),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: width * 0.38,
                  height: height * 0.25,
                  child: Assets.svg.hiGLogo.svg(),
                ),
              ),
              const SizedBox(height: 30),
              Button(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         duration: const Duration(milliseconds: 100),
                  //         type: PageTransitionType.rightToLeft,
                  //         child: const PassCodeScreen()));
                },
                width: width,
                title: 'create_new_wallet',
                subtitle: 'secret_phrase',
                icon: Icons.add,
              ),
              const SizedBox(height: 26),
              Button(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         duration: const Duration(milliseconds: 100),
                  //         type: PageTransitionType.rightToLeft,
                  //         child: const InputSecretKey()));
                },
                width: width,
                title: 'add_existing_wallet',
                subtitle: 'import_restore_view_only',
                icon: Icons.arrow_downward_rounded,
              ),
              const SizedBox(height: 36),
              Text(
                S.current.popular_communities,
                textAlign: TextAlign.left,
                style: AppTextStyles.s14BoldPopular(),
              ),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CommunityCard(
                    image: Assets.images.karol,
                    name: 'Karol G',
                    country: S.current.global_community,
                    members: '20M',
                  ),
                  CommunityCard(
                    image: Assets.images.rectangle37,
                    name: 'Design Freelancers',
                    country: 'UK',
                    members: '200k',
                  ),
                  CommunityCard(
                    image: Assets.images.seconC,
                    name: 'Burning Man',
                    country: S.current.global_community,
                    members: '20K',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
