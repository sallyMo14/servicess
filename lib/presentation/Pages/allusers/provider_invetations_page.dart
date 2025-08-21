import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../provideruser/invetation_details_page.dart';
import '../../bloc/invetation/invetation_bloc.dart';
import '../../widgets/Cards/service_card.dart';

class ProviderInvetationsPage extends StatefulWidget {
  const ProviderInvetationsPage({Key? key}) : super(key: key);

  @override
  State<ProviderInvetationsPage> createState() =>
      _ProviderInvetationsPageState();
}

class _ProviderInvetationsPageState
    extends State<ProviderInvetationsPage> {
  @override
  void initState() {
    super.initState();
    _fetchInvitations();
  }

  void _fetchInvitations() {
    context.read<InvetationBloc>().add(
      GetInvetationsEvent(userId: 'provider_123'),
    );
  }

  Future<void> _navigateToDetails(
    BuildContext context,
    String invitationId,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => InvitationDetailsPage(invitationId: invitationId),
      ),
    );
    // Refresh when coming back from the details page
    _fetchInvitations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invitations')),
      body: BlocBuilder<InvetationBloc, InvetationState>(
        builder: (context, state) {
          if (state is InvetationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GotInvetationsState) {
            final invitations = state.invetations;

            if (invitations.isEmpty) {
              return const Center(
                child: Text('No invitations available.'),
              );
            }

            return ListView.builder(
              itemCount: invitations.length,
              itemBuilder: (context, index) {
                final entry = invitations.entries.elementAt(index);
                final id = entry.key;
                // Replace these dummy values with real data:
                return ServiceCard(
                  timeAgo: '2d ago',
                  title: 'Job Title',
                  userName: 'Client Name',
                  location: 'Location',
                  price: '1500\$ / M',
                  rating: 4,
                  description: 'Short description...',
                  avatarPath: 'assets/images/avatar.png',
                  onTap: () => _navigateToDetails(context, id),
                );
              },
            );
          } else if (state is InvetationExceptionState) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(
            child: Text('Waiting for invitations...'),
          );
        },
      ),
    );
  }
}

/*
//! old code
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicess/presentation/Pages/provideruser/invetation_details_page.dart';
import 'package:servicess/presentation/bloc/invetation/invetation_bloc.dart';
import 'package:servicess/presentation/widgets/Cards/service_card.dart';


class ProviderInvetationsPage extends StatefulWidget {
  const ProviderInvetationsPage({Key? key}) : super(key: key);

  @override
  State<ProviderInvetationsPage> createState() => _ProviderInvetationsPageState();
}

class _ProviderInvetationsPageState extends State<ProviderInvetationsPage> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      context.read<InvetationBloc>().add(GetInvetationsEvent(userId: 'provider_123'));
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invitations')),
      body: BlocBuilder<InvetationBloc, InvetationState>(
        builder: (context, state) {
          if (state is InvetationLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GotInvetationsState) {
            final invitations = state.invetations;

            if (invitations.isEmpty) {
              return Center(child: Text('No invitations available.'));
            }

            return ListView.builder(
              itemCount: invitations.length,
              itemBuilder: (context, index) {
                final entry = invitations.entries.elementAt(index);
                final id = entry.key;
                // final data = entry.value;

                return ServiceCard(timeAgo: 'timeAgo', title: 'title', userName:' userName', location: 'location', price: 'price', rating: 5, description: 'description', avatarPath: 'avatarPath', onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => InvitationDetailsPage(invitationId:id ,),));
                });
              },
            );
          } else if (state is InvetationExceptionState) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return Center(child: Text('Waiting for invitations...'));
        },
      ),
    );
  }
}

 */
// !older code
// import 'package:flutter/material.dart';
// import 'package:servicess/presentation/Pages/provideruser/invetation_details_page.dart';
// import 'package:servicess/presentation/widgets/Cards/service_card.dart';

// class ProviderInvetationsPage extends StatelessWidget {
//   const ProviderInvetationsPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 3,
//       itemBuilder:
//           (context, index) => Column(
//             children: [
//               SizedBox(height: 20),
//               ServiceCard(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) =>
//                               InvitationDetailsPage(),
//                     ),
//                   );
//                 },
//                 timeAgo: '15',
//                 title: 'FaceBook Social Media Design',
//                 userName: 'Madeha Ahmed',
//                 location: 'Lebanon',
//                 price: '1500/Month',
//                 rating: 3,
//                 description:
//                     'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                 avatarPath: 'assets/images/avatar.png',
//               ),
//             ],
//           ),
//     );
//   }
// }
