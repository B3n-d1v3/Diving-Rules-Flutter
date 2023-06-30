import 'package:diving_rules_hybrid/buttons/button_penalties.dart';
import 'package:diving_rules_hybrid/models/penalty_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/diving_rules_localizations.dart';

import '../buttons/button_ownership.dart';
import '../l10n/penalty_description_l10n.dart';
import '../models/globals.dart';
import '../models/sanction_model.dart';
import '../theme/dr_colors.dart';

class PagePenaltyDescription extends StatefulWidget {
  int index;

  PagePenaltyDescription({Key? key, required this.index}) : super(key: key);

  @override
  _PagePenaltyDescriptionState createState() => _PagePenaltyDescriptionState();
}

class _PagePenaltyDescriptionState extends State<PagePenaltyDescription> {
  late PenaltySanction penaltySanction;

  @override
  void initState() {
    //Set the PenaltySanction values
    penaltySanction = setPenaltySanction(
        penaltyNb: penaltySummary.penalties[widget.index].sanctionValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.penaltiesListTitle),
      ),
      //   // Retrieves the screen size
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height,

      body: SafeArea(
          child: Scrollbar(
              child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // left / right navigation in the penalty list to avoid going back to the main list
              // use example: https://www.youtube.com/watch?v=Kc-2MtZnfFo

              // The Header + next / previous navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Previous button
                  IconButton(
                      icon: (widget.index > 0)
                          ? Icon(CupertinoIcons.arrowtriangle_left_fill)
                          : Icon(CupertinoIcons.arrowtriangle_left),
                      // To be localized
                      tooltip: 'Previous',
                      color: (widget.index > 0)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.tertiary,
                      onPressed: () {
                        setState(
                          () {
                            if (widget.index > 0) {
                              widget.index--;
                              penaltySanction = setPenaltySanction(
                                  penaltyNb: penaltySummary
                                      .penalties[widget.index].sanctionValue);
                            }
                          },
                        );
                      }),

                  // Header
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                        style: Theme.of(context).textTheme.headlineMedium,
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!.penaltyRule,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ],
                      )),
                    ),
                  ),

                  // Next Button
                  IconButton(
                    icon: (widget.index < penaltySummary.penalties.length - 1)
                        ? Icon(CupertinoIcons.arrowtriangle_right_fill)
                        : Icon(CupertinoIcons.arrowtriangle_right),
                    // To be localized
                    tooltip: 'Next',
                    color: (widget.index < penaltySummary.penalties.length - 1)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
                    onPressed: () {
                      setState(() {
                        if (widget.index <
                            penaltySummary.penalties.length - 1) {
                          widget.index++;
                          penaltySanction = setPenaltySanction(
                              penaltyNb: penaltySummary
                                  .penalties[widget.index].sanctionValue);
                        }
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Description Title
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!.penaltyDescription,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                )),
              ),

              // Description Content
              Align(
                alignment: Alignment.centerLeft,
                child: PenaltyDescription(penaltyId: widget.index),
              ),
              SizedBox(height: 10),

              // Rules References
              Align(
                alignment: Alignment.centerRight,
                child: DisplayRulesReferences(
                    rulesReferences:
                        penaltySummary.penalties[widget.index].rules),
              ),
              const Divider(
                height: 20,
                thickness: .5,
                indent: 10,
                endIndent: 10,
                color: AppColor.drColorDeselectedLight,
              ),

              // Penalty Sanction
              // Penalty Title
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!.penaltyPenalty,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                )),
              ),
              SizedBox(height: 10),

              // GridView to display the Penalty Sanctions
              GridView.count(
                crossAxisCount: 3,
                primary: false,
                padding: const EdgeInsets.all(1),
                childAspectRatio: (1 / .8),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  PenaltyButton(buttonType: 0, penaltyIndex: widget.index),
                  PenaltyButton(buttonType: 1, penaltyIndex: widget.index),
                  PenaltyButton(buttonType: 2, penaltyIndex: widget.index),
                  PenaltyButton(buttonType: 3, penaltyIndex: widget.index),
                  PenaltyButton(buttonType: 4, penaltyIndex: widget.index),
                  PenaltyButton(buttonType: 5, penaltyIndex: widget.index),
                ],
              ),

              const Divider(
                height: 10,
                thickness: .5,
                indent: 10,
                endIndent: 10,
                color: AppColor.drColorDeselectedLight,
              ),

              // Penalty ownership
              // Penalty Title
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!.penaltyOwnership,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                )),
              ),

              SizedBox(height: 10),

              // GridView to display the Penalty Owners
              GridView.count(
                crossAxisCount: 2,
                primary: false,
                padding: const EdgeInsets.all(1),
                childAspectRatio: (1 / .7),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  OwnershipButton(buttonType: 0, penaltyIndex: widget.index),
                  OwnershipButton(buttonType: 1, penaltyIndex: widget.index),
                ],
              ),
            ],
          ),
        ),
      ))),
    );
  }
}

class DisplayRulesReferences extends StatelessWidget {
  final List<Rule> rulesReferences;

  DisplayRulesReferences({required this.rulesReferences});

  @override
  Widget build(BuildContext context) {
    String rulesToDisplay = "";
    for (var i = 0; i < rulesReferences.length; i++) {
      rulesToDisplay = rulesToDisplay + " - ${rulesReferences[i].ruleId}";
    }
    return (RichText(
        text: TextSpan(
      style: Theme.of(context).textTheme.labelMedium,
      children: [
        TextSpan(
            text: rulesToDisplay,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
            )),
      ],
    )));
  }
}
