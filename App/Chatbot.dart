import '/backend/gemini/gemini.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'fitbitz_model.dart';
export 'fitbitz_model.dart';

class FitbitzWidget extends StatefulWidget {
  const FitbitzWidget({super.key});

  @override
  State<FitbitzWidget> createState() => _FitbitzWidgetState();
}

class _FitbitzWidgetState extends State<FitbitzWidget> {
  late FitbitzModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FitbitzModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0, -1),
            child: Text(
              'FIT BITZ',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: Color(0xFFEF7E39),
                    fontSize: 31,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 581,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  valueOrDefault<String>(
                    _model.response,
                    'Hello, I am Fitness Bot! Feel free to ask...',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 5),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'What is Question?',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'TextField',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF7E39),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      await geminiGenerateText(
                        context,
                        _model.textController.text,
                      ).then((generatedText) {
                        safeSetState(() => _model.response = generatedText);
                      });

                      safeSetState(() {});
                    },
                    text: 'Submit',
                    options: FFButtonOptions(
                      width: 127,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFFEF7E39),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        safeSetState(() {
                          _model.textController?.clear();
                        });
                      },
                      text: 'Reset',
                      options: FFButtonOptions(
                        width: 127,
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter Tight',
                                  color: Color(0xFFEF7E39),
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Color(0xFFEF7E39),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
