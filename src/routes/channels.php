<?php

use Illuminate\Support\Facades\Broadcast;

Broadcast::channel('pubsub', function ($user, $id) {
    return (int) $user->id === (int) $id;
});
