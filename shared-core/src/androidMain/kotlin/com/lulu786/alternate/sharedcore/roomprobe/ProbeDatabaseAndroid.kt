package com.lulu786.alternate.sharedcore.roomprobe

import android.content.Context
import androidx.room.Room
import androidx.sqlite.driver.bundled.BundledSQLiteDriver

/**
 * Does not touch Alternate's existing database or migrations.
 */
fun openAndroidProbeDatabase(context: Context): ProbeDatabase =
    Room.databaseBuilder<ProbeDatabase>(
        context.applicationContext,
        "alternate_kmp_room_spike.db"
    )
        .setDriver(BundledSQLiteDriver())
        .build()
