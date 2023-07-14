import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/enums.dart';

class CustomDialog extends ConsumerStatefulWidget {
  CustomDialog({
    required this.title,
    required this.description,
    this.yes = "Yes",
    this.no = "No",
    this.condition,
    this.loadingRequired = false,
    this.noTextColor = Colors.white,
    required this.yesFunction,
    this.noFunction,
    required this.yesColor,
    required this.noColor,
  });
  String title;
  String description;
  String yes;
  String no;
  bool loadingRequired;
  String? condition;
  Color noTextColor;
  Function? yesFunction;
  Function? noFunction;
  Color yesColor;
  Color noColor;
  @override
  ConsumerState<CustomDialog> createState() => _MyDialogState();
}

class _MyDialogState extends ConsumerState<CustomDialog> {
  Status condition = Status.empty;
  @override
  void initState() {
    widget.yesColor = widget.yesColor ?? const Color(0xff52BD94);
    widget.noColor = widget.noColor ?? const Color(0xffdc2626);
    widget.noFunction = widget.noFunction ??
        () {
          Navigator.pop(context);
        };

    super.initState();
  }

  conditionSetter(BuildContext ctx) {
    var prov = ref.read(Const.firebase);
    if (widget.condition == "DELETE") {
 if (prov.passwordDeleteStatus == Status.failed) {
        prov.passwordDeleteStatus = Status.empty;
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
      setState(() {
        condition = prov.passwordDeleteStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(Const.firebase);
    if (widget.loadingRequired) {
      conditionSetter(context);
    }
    return GestureDetector(
      onTap: () {
        if (condition == Status.loading) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: prov.darkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.lato(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.description,
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    (condition == Status.failed || condition == Status.empty)
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: widget.noFunction as void Function()?,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: widget.noColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 13,
                                          right: 13),
                                      child: Center(
                                        child: Text(
                                          widget.no,
                                          style: GoogleFonts.lato(
                                              color: widget.noTextColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: widget.yesFunction as void Function()?,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: widget.yesColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 13,
                                          right: 13),
                                      child: Center(
                                          child: Text(
                                        widget.yes,
                                        maxLines: 2,
                                        style: GoogleFonts.lato(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : widget.loadingRequired && condition == Status.loading
                            ? Container(
                                margin: const EdgeInsets.only(right: 0),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    condition == Status.loading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : Container()
                                  ],
                                ),
                              )
                            : Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
