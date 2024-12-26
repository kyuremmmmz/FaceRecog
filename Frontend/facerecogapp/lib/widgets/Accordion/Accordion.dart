import 'package:custom_accordion/custom_accordion.dart';
import 'package:facerecogapp/widgets/ReusableCodes/Columns.dart';
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  const Accordion({super.key});

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
                  title: 'Today\'s Class',
                  headerBackgroundColor: Colors.white,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                  toggleIconClose: Icons.keyboard_arrow_up_sharp,
                  headerIconColor: Colors.black,
                  accordionElevation: 0,
                  showContent: true,
                  widgetItems: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          child: ListBody(
                            children: [
                              Columns(
                                avatarLabel: 'M', 
                                time: '9:30 am', 
                                subject: 'Mathematics'),
                              const SizedBox(
                                height: 10,
                              ),
                              Columns(
                                  avatarLabel: 'P',
                                  time: '10:30 am',
                                  subject: 'Physics'),
                              const SizedBox(
                                height: 10,
                              ),
                              Columns(
                                  avatarLabel: 'B',
                                  time: '11:30 am',
                                  subject: 'Biology'),
                              const SizedBox(
                                height: 10,
                              ),
                              Columns(
                                  avatarLabel: 'G',
                                  time: '1:30 pm',
                                  subject: 'Geography'),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
  }
}