import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/register_user_info.dart';

@RoutePage()
class RegisterUserInfoPage extends StatefulWidget {
  const RegisterUserInfoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterUserInfoPageState();
  }
}

class _RegisterUserInfoPageState
    extends BasePageState<RegisterUserInfoPage, RegisterUserInfoBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final dimen = AppDimen.current;
    final width = dimen.screenWidth;
    final height = dimen.screenHeight;

    return BlocBuilder<RegisterUserInfoBloc, RegisterUserInfoState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return CommonScaffold(
          appBar: CommonAppBar(
            automaticallyImplyLeading: false,
            text: 'my_profile',
            leadingIcon: LeadingIcon.none,
            actions: [
              ElevatedButton(
                onPressed: () {
                  // bloc.add(const Skip());
                },
                style: AppButtonStyles.getAppBarButtonStyle(),
                child: Text(
                  'skip',
                  style: AppTextStyles.s18w500Icons(
                    fontFamily: FontFamily.ntr,
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SafeArea(
            child: Container(
              width: width,
              height: height,
              padding:
                  const EdgeInsets.symmetric(horizontal: UiConstants.commonP),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width * 0.5,
                      child: GestureDetector(
                        onTap: () {
                          // bloc.add(const SelectImage());
                        },
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Assets.images.group36.image(
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimens.d5.responsive()),
                    Text(
                      'profile_image',
                      style: AppTextStyles.s18w500Popular(),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      title: 'name',
                      hintText: 'name',
                      // enabled: enabled,
                      // error: _nameError,
                      // controller: _nameController,
                      // maxLength: UserPaymentMethodEntity.nameML,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: Dimens.d10.responsive()),
                    AppTextField(
                      title: 'lastname',
                      hintText: 'lastname',
                      // enabled: enabled,
                      // error: _lastnameError,
                      // controller: _lastnameController,
                      // maxLength: UserPaymentMethodEntity.nameML,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: Dimens.d10.responsive()),
                    AppTextField(
                      title: 'username',
                      hintText: 'username',
                      suffix: GestureDetector(
                        onTap: () {
                          // bloc.add(const GenerateUserName());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Text(
                                'auto_generate',
                                style: AppTextStyles.s12w500Primary(),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                LucideIcons.dice2,
                                color: Colors.white,
                                size: UiConstants.iconSizeM,
                              )
                            ],
                          ),
                        ),
                      ),
                      // enabled: enabled,
                      // error: _lastnameError,
                      // controller: _lastnameController,
                      // maxLength: UserPaymentMethodEntity.nameML,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: Dimens.d10.responsive()),
                    AppDropDown(
                      enabled: true,
                      title: 'preferred_language',
                      hintText: 'preferred_language',
                      value: '1',
                      items: ['1', '2', '3'],
                      itemBuilder: (x, _) => DropdownMenuItem(
                        value: x,
                        child: Text(x),
                      ),
                      onChanged: (_) {},
                      onTap: () {},
                    ),
                    SizedBox(height: Dimens.d10.responsive()),
                    AppDropDown(
                      enabled: true,
                      title: 'preferred_app_language',
                      hintText: 'preferred_app_language',
                      value: 'a',
                      items: ['a', 'b', 'c'],
                      itemBuilder: (x, _) => DropdownMenuItem(
                        value: x,
                        child: Text(x),
                      ),
                      onChanged: (_) {},
                      onTap: () {},
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // bloc.add(const TapOnContinue());
                      },
                      style: AppButtonStyles.getBasicStyle(),
                      child: Container(
                        alignment: Alignment.center,
                        width: width,
                        child: Text(S.current.continue_),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
