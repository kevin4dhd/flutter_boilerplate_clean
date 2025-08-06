import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pincode_input_fields/pincode_input_fields.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/pass_code.dart';

@RoutePage()
class PassCodePage extends StatefulWidget {
  const PassCodePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PassCodePageState();
  }
}

class _PassCodePageState extends BasePageState<PassCodePage, PassCodeBloc> {
  late final _controller = PincodeInputFieldsController()
    ..disposeBy(disposeBag);
  late final _focusNode = FocusNode()..disposeBy(disposeBag);

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PassCodeBloc, PassCodeState>(
          listenWhen: (previous, current) => current.shouldClearPin,
          listener: (context, state) {
            if (state.shouldClearPin) {
              _controller.clear();
              bloc.add(const PassCodePinClear());
              Future.delayed(DurationConstants.commonCallbackDuration)
                  .then((_) => _focusNode.requestFocus());
            }
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    final dimen = AppDimen.current;
    final width = dimen.screenWidth;
    final height = dimen.screenHeight;
    return CommonScaffold(
      appBar: CommonAppBar(),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.18),
                Text(
                  S.current.createPasscode,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s17w400Primary(),
                ),
                SizedBox(height: height * 0.03),
                AppPinput(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: (passCode) =>
                      bloc.add(PassCodePinChanged(passCode: passCode)),
                  onCompleted: (passCode) =>
                      bloc.add(PassCodePinCompleted(passCode: passCode)),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  S.current.enterPasscodeRemember,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s15w400Popular(letterSpacing: -0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
