import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import 'bloc/my_page.dart';

@RoutePage(name: 'MyPageRoute')
class MyPagePage extends StatefulWidget {
  const MyPagePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPagePageState();
  }
}

class _MyPagePageState extends BasePageState<MyPagePage, MyPageBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) =>
                    previous.isDarkTheme != current.isDarkTheme,
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: Text(
                      S.current.darkTheme,
                      style: AppTextStyles.s14w400Primary(),
                    ),
                    tileColor: AppColors.current.primaryColor,
                    value: state.isDarkTheme,
                    onChanged: (isDarkTheme) => appBloc.add(
                      AppThemeChanged(isDarkTheme: isDarkTheme),
                    ),
                  );
                },
              ),
              BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) =>
                    previous.languageCode != current.languageCode,
                builder: (context, state) {
                  return DropdownButton<LanguageCode>(
                    value: state.languageCode,
                    onChanged: (selectedLanguage) {
                      if (selectedLanguage != null) {
                        appBloc.add(
                            AppLanguageChanged(languageCode: selectedLanguage));
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: LanguageCode.en,
                        child: Text(S.current.english),
                      ),
                      DropdownMenuItem(
                        value: LanguageCode.ja,
                        child: Text(S.current.japanese),
                      ),
                      DropdownMenuItem(
                        value: LanguageCode.es,
                        child: Text(S.current.spanish),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: Dimens.d15.responsive()),
              ElevatedButton(
                onPressed: () => bloc.add(const LogoutButtonPressed()),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColors.current.primaryColor),
                ),
                child: Text(
                  S.current.logout,
                  style: AppTextStyles.s14w400Primary(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
