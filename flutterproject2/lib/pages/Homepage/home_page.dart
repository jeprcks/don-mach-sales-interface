import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of new branch images and details
    final List<Map<String, String>> branches = [
      {
        'title': 'Grand Opening - Opol Branch',
        'image': 'assets/branchopol.png',
        'description': 'Join us in celebrating the grand opening of our Opol branch. Enjoy our 3-for-100 promo!',
      },
      {
        'title': 'Outreach Program - Dasmariñas',
        'image': 'assets/branchdasmarinas.png',
        'description': 'Our Dasmariñas branch conducted an outreach program to give back to the community.',
      },
      {
        'title': 'Brewing Soon - Buhisan Branch',
        'image': 'assets/branchbuhisan.png',
        'description': 'Get ready, coffee lovers! Buhisan branch is opening soon!',
      },
      {
        'title': 'Grand Opening - Tabunok Branch',
        'image': 'assets/branchtabunok.png',
        'description': 'Grand opening celebration with special guest Ariel Alegado. Don’t miss out!',
      },
      {
        'title': 'On-the-Go Booth',
        'image': 'assets/branchbooth.png',
        'description': 'Catch us at our on-the-go booths for a quick coffee fix.',
      },
      {
        'title': 'Now Open - PSU Lingayen',
        'image': 'assets/branchlingayen.png',
        'description': 'The PSU Lingayen branch is now open! See you, Kape-Pol!',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Don Macchiatos ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      backgroundColor: Colors.brown,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/donmac.jpg'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/dashboardpage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits_sharp),
              title: const Text('Products'),
              onTap: () {
                Navigator.pushNamed(context, '/products');
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.storage),
            //   title: const Text('Stocks'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/stockpage');
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Sale'),
              onTap: () {
                Navigator.pushNamed(context, '/salespage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Transaction'),
              onTap: () {
                Navigator.pushNamed(context, '/transactionpage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Create User'),
              onTap: () {
                Navigator.pushNamed(context, '/createuserpage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Branch Highlights',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: branches.length,
                  itemBuilder: (context, index) {
                    final branch = branches[index];
                    return Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            child: Image.asset(
                              height: MediaQuery.of(context).size.width / 1.5,
                              branch['image']!,
                              width: double.infinity,
                              fit: BoxFit.contain, // Ensures the full image is visible
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              branch['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              branch['description']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
