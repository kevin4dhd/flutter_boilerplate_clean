import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pincode_input_fields/pincode_input_fields.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/confirm_pass_code.dart';
import 'widgets/widgets.dart';

@RoutePage()
class ConfirmPassCodePage extends StatefulWidget {
  const ConfirmPassCodePage({
    required this.passCode,
    super.key,
  });

  final String passCode;

  @override
  State<StatefulWidget> createState() {
    return _ConfirmPassCodePageState();
  }
}

class _ConfirmPassCodePageState
    extends BasePageState<ConfirmPassCodePage, ConfirmPassCodeBloc> {
  late final _controller = PincodeInputFieldsController()
    ..disposeBy(disposeBag);
  late final _focusNode = FocusNode()..disposeBy(disposeBag);

  late final _isIOS = Platform.isIOS;
  final canCheckBiometrics =
      GetIt.instance.get<DeviceInfo>().canCheckBiometrics;

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmPassCodeBloc, ConfirmPassCodeState>(
          listenWhen: (previous, current) => current.shouldClearPin,
          listener: (context, state) {
            if (state.shouldClearPin) {
              _controller.clear();
              bloc.add(const ConfirmPassCodePinClear());
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
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return BlocBuilder<ConfirmPassCodeBloc, ConfirmPassCodeState>(
      buildWhen: (previous, current) =>
          previous.enabledBiometric != current.enabledBiometric,
      builder: (context, state) {
        final enabledBiometric = state.enabledBiometric;
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
                    const SizedBox(height: 20),
                    FaceIdOrFingerprint(
                      enabled: enabledBiometric,
                      isIOS: _isIOS,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.current.confirmPasscode,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s17w400Primary(),
                    ),
                    const SizedBox(height: 20),
                    AppPinput(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: (confirmPassCode) => bloc.add(
                        ConfirmPassCodePinChanged(
                          confirmPassCode: confirmPassCode,
                        ),
                      ),
                      onCompleted: (confirmPassCode) => bloc.add(
                        ConfirmPassCodePinCompleted(
                          confirmPassCode: confirmPassCode,
                          passCode: widget.passCode,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.current.confirmPasscodeInstruction,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s15w400Popular(letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 20),
                    if (canCheckBiometrics)
                      FaceIdOrFingerprintSwitch(
                        isIOS: _isIOS,
                        value: enabledBiometric,
                        onChanged: (enabledBiometric) => bloc.add(
                          EnableBiometric(
                            enabledBiometric: enabledBiometric,
                          ),
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
