package com.lulu786.alternate.sharedcore.roomprobe

import androidx.room.Room
import androidx.sqlite.driver.bundled.BundledSQLiteDriver

/**
 * Test-only database, with an explicitly supplied path. A production database
 * must use protected app storage and a separately reviewed backup policy.
 */
fun openIosProbeDatabase(filePath: String): ProbeDatabase =
    Room.databaseBuilder<ProbeDatabase>(name = filePath)
        .setDriver(BundledSQLiteDriver())
        .build()
