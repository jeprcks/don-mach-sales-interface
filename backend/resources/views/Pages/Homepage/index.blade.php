@extends('Layout.app')
@section('title', 'Don Macchiatos')
@include('Components.NaBar.navbar')
@section('content')
    <div
        style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f7f0e3; min-height: 100vh; display: flex; flex-direction: row; justify-content: center; align-items: center;">
        <Sidebar />
        <main style="flex: 1; padding: 20px; display: flex; flex-direction: column; align-items: center;">
            <h1
                style="font-size: 3rem; font-weight: bold; text-align: center; color: #4b3025; margin-bottom: 20px; text-transform: uppercase; letter-spacing: 3px; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); padding: 10px 0; border-bottom: 2px solid #d49d6e; display: inline-block; margin-top: 20px;">
                Don Macchiatos</h1>
            <h2 style="font-size: 2rem; color: #4b3025; margin-bottom: 20px; font-weight: bold;">Branch Highlights</h2>
            <div
                style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; width: 100%; max-width: 1500px; justify-content: center;">
                <!-- Branch 1 -->
                <div
                    style="background-color: #fff8e7; border-radius: 12px; overflow: hidden; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); padding: 150px; text-align: center;">
                    <!-- Adjusted padding for a slightly bigger box -->
                    <Image src="/images/branchopol.png" alt="Opol Branch" layout="responsive" width={500} height={300}
                        style="border-radius: 12px;" />
                    <p style="margin-top: 10px; font-size: 1rem; color: #4b3025; font-weight: bold;">
                        <strong>Grand Opening - Opol Branch</strong>
                        <br />
                        Join us in celebrating the grand opening of our Opol branch.
                        Enjoy our 3-for-100 promo!
                    </p>
                </div>

                <!-- Branch 2 -->
                <div
                    style="background-color: #fff8e7; border-radius: 12px; overflow: hidden; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); padding: 150px; text-align: center;">
                    <!-- Adjusted padding for a slightly bigger box -->
                    <Image src="/images/branchdasmarinas.png" alt="Dasmarinas Branch" layout="responsive" width={500}
                        height={300} style="border-radius: 12px;" />
                    <p style="margin-top: 10px; font-size: 1rem; color: #4b3025; font-weight: bold;">
                        <strong>Dasmarinas Branch</strong>
                        <br />
                        Our Dasmariñas branch conducted an outreach program to give back to the community.
                    </p>

                </div>
                <!-- Branch 3 -->
                <div
                    style="background-color: #fff8e7; border-radius: 12px; overflow: hidden; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); padding: 150px; text-align: center;">
                    <!-- Adjusted padding for a slightly bigger box -->
                    <Image src="/images/branchlingayen.png" alt="Lingayen Branch" layout="responsive" width={500}
                        height={300} style="border-radius: 12px;" />
                    <p style="margin-top: 10px; font-size: 1rem; color: #4b3025; font-weight: bold;">
                        <strong>Lingayen Branch</strong>
                        <br />
                        Get ready, coffee lovers! Buhisan branch is opening soon!!
                    </p>
                </div>

                <!-- Branch 4 -->
                <div
                    style="background-color: #fff8e7; border-radius: 12px; overflow: hidden; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); padding: 150px; text-align: center;">
                    <!-- Adjusted padding for a slightly bigger box -->
                    <Image src="/images/branchopol.png" alt="Pol Branch" layout="responsive" width={500} height={300}
                        style="border-radius: 12px;" />
                    <p style="margin-top: 10px; font-size: 1rem; color: #4b3025; font-weight: bold;">
                        <strong>Opol Branch</strong>
                        <br />
                        'Join us in celebrating the grand opening of our Opol branch. Enjoy our 3-for-100 promo!
                    </p>
                </div>
                <div
                    style="background-color: #fff8e7; border-radius: 12px; overflow: hidden; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); padding: 150px; text-align: center;">
                    <!-- Adjusted padding for a slightly bigger box -->
                    <Image src="/images/branchtabunok.png" alt="Pol Branch" layout="responsive" width={500} height={300}
                        style="border-radius: 12px;" />
                    <p style="margin-top: 10px; font-size: 1rem; color: #4b3025; font-weight: bold;">
                        <strong>Tabunok</strong>
                        <br />
                        Grand opening celebration with special guest Ariel Alegado. Don't miss out!
                    </p>
                </div>
                <div
                    style="background-color: #fff8e7; border-radius: 12px; overflow: hidden; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); padding: 150px; text-align: center;">
                    <!-- Adjusted padding for a slightly bigger box -->
                    <Image src="/images/branchbuhisan.png" alt="Pol Branch" layout="responsive" width={500} height={300}
                        style="border-radius: 12px;" />
                    <p style="margin-top: 10px; font-size: 1rem; color: #4b3025; font-weight: bold;">
                        <strong>Buhisan Branch</strong>
                        <br />
                        Get ready, coffee lovers! Buhisan branch is opening soon!
                    </p>
                </div>
            </div>

        </main>
    </div>
@endsection
