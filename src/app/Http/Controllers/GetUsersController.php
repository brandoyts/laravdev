<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class GetUsersController extends Controller
{
    public function getUsers(Request $request)
    {
        $users = User::all();

        return response()->json([
            "message" => "success",
            "users" => $users
        ]);
    }
}
