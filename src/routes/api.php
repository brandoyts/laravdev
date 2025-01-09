<?php

use App\Http\Controllers\GetUsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;



Route::middleware("auth:sanctum")
->group(function () {
    Route::get("/users", [GetUsersController::class, "getUsers"]);

    Route::get("/user", function (Request $request) {
            return $request->user();
    });
});




