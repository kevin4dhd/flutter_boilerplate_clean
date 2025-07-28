import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app.dart';
import 'bloc/messages.dart';
import 'package:intl/intl.dart';

@RoutePage()
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MessagesPageState();
  }
}

class _MessagesPageState extends BasePageState<MessagesPage, MessagesBloc> {
  late final CommonPagingController<Message> _pagingController =
      CommonPagingController<Message>()..disposeBy(disposeBag);
  late final MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    bloc.add(const MessagesPageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const MessagesLoadMore()),
    );
    _channel = const MethodChannel('sync_channel');
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'dataUpdated') {
        final text = call.arguments as String?;
        if (text != null) {
          bloc.add(
            MessagesUpdated(Message(text: text, createdAt: DateTime.now())),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _channel.setMethodCallHandler(null);
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return BlocListener<MessagesBloc, MessagesState>(
      listenWhen: (previous, current) => previous.messages != current.messages,
      listener: (context, state) {
        _pagingController.appendLoadMoreOutput(state.messages);
      },
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: 'Messages',
        leadingIcon: navigator.canPopSelfOrChildren
            ? LeadingIcon.back
            : LeadingIcon.none,
        backgroundColor: AppColors.current.primaryColor,
        titleTextStyle: AppTextStyles.s14w400Primary(),
      ),
      body: BlocBuilder<MessagesBloc, MessagesState>(
        buildWhen: (previous, current) => previous.messages != current.messages,
        builder: (context, state) {
          return CommonPagedListView<Message>(
            pagingController: _pagingController,
            itemBuilder: (context, msg, index) => Padding(
              padding: EdgeInsets.all(Dimens.d4.responsive()),
              child: Text(
                '${DateFormat.Hms().format(msg.createdAt ?? DateTime.now())} - ${msg.text}',
                style: AppTextStyles.s14w400Primary(),
              ),
            ),
          );
        },
      ),
    );
  }
}
