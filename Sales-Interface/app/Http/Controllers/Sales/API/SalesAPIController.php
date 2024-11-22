<?php

namespace App\Http\Controllers\Sales\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SalesAPIController extends Controller
{
    public function create(Request $request)
    {
        $data = $request->all();

        return response()->json($data);
        // $validate = Validator::make();
    }
}
