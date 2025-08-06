import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/auth.dart';
import 'widgets/widgets.dart';

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
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return CommonScaffold(
      appBar: CommonAppBar(height: 0),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: UiConstants.commonPB),
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
                WalletActionButton(
                  onTap: () => bloc.add(const ClickOnCreate()),
                  width: width,
                  title: S.current.createNewWallet,
                  subtitle: S.current.secretPhrase,
                  icon: Icons.add,
                ),
                const SizedBox(height: 26),
                WalletActionButton(
                  onTap: () => bloc.add(const ClickOnImport()),
                  width: width,
                  title: S.current.addExistingWallet,
                  subtitle: S.current.importRestoreViewOnly,
                  icon: Icons.arrow_downward_rounded,
                ),
                const SizedBox(height: 36),
                Text(
                  S.current.popularCommunities,
                  textAlign: TextAlign.left,
                  style: AppTextStyles.s14BoldPopular(),
                ),
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PopularCommunityCard(
                      image: Assets.images.karol,
                      name: 'Karol G',
                      country: S.current.globalCommunity,
                      members: '20M',
                    ),
                    PopularCommunityCard(
                      image: Assets.images.rectangle37,
                      name: 'Design Freelancers',
                      country: 'UK',
                      members: '200k',
                    ),
                    PopularCommunityCard(
                      image: Assets.images.seconC,
                      name: 'Burning Man',
                      country: S.current.globalCommunity,
                      members: '20K',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
