<?php

namespace Database\Seeders;

use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class TransactionSeeder extends Seeder
{
    public function run()
    {
        // Create some test transactions for the last 30 days
        for ($i = 0; $i < 30; $i++) {
            $date = Carbon::now()->subDays($i);

            // Create 1-5 transactions per day
            $transactionsPerDay = rand(1, 5);

            for ($j = 0; $j < $transactionsPerDay; $j++) {
                Transaction::create([
                    'total_amount' => rand(100, 1000),
                    'created_at' => $date,
                ]);
            }
        }
    }
}
