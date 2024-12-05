<?php

namespace App\Http\Controllers\Dashboard\WEB;

use App\Http\Controllers\Controller;
use App\Infrastructure\Persistence\Eloquent\Sales\SalesModel;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class DashboardWEBController extends Controller
{
    public function index()
    {
        $today = Carbon::today();

        // Daily Sales (today)
        $dailySales = SalesModel::select(
            DB::raw('DATE(created_at) as date'),
            DB::raw('SUM(total_order) as total_sales'),
            DB::raw('COUNT(*) as transaction_count')
        )
            ->whereDate('created_at', $today)
            ->groupBy('date')
            ->get();

        // Weekly Sales (last 7 days including today)
        $weeklySales = SalesModel::select(
            DB::raw('DATE(created_at) as date'),
            DB::raw('SUM(total_order) as total_sales'),
            DB::raw('COUNT(*) as transaction_count')
        )
            ->whereBetween('created_at', [
                $today->copy()->subDays(6)->startOfDay(),
                $today->copy()->endOfDay(),
            ])
            ->groupBy('date')
            ->get();

        // Monthly Sales (current month)
        $monthlySales = SalesModel::select(
            DB::raw('DATE(created_at) as date'),
            DB::raw('SUM(total_order) as total_sales'),
            DB::raw('COUNT(*) as transaction_count')
        )
            ->whereYear('created_at', $today->year)
            ->whereMonth('created_at', $today->month)
            ->groupBy('date')
            ->get();

        // Yearly Sales (current year)
        $yearlySales = SalesModel::select(
            DB::raw('DATE(created_at) as date'),
            DB::raw('SUM(total_order) as total_sales'),
            DB::raw('COUNT(*) as transaction_count')
        )
            ->whereYear('created_at', $today->year)
            ->groupBy('date')
            ->get();

        return view('Pages.Dashboard.index', compact(
            'dailySales',
            'weeklySales',
            'monthlySales',
            'yearlySales'
        ));
    }
}
