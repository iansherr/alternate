package com.lulu786.alternate.sharedcore.roomprobe

import kotlinx.coroutines.runBlocking
import platform.Foundation.NSTemporaryDirectory
import platform.Foundation.NSUUID
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull

class RoomIosPersistenceTest {
    @Test
    fun insertUpdateDeleteSurviveReopen() = runBlocking {
        val path = NSTemporaryDirectory() + "/alternate-room-spike-" +
            NSUUID().UUIDString + ".sqlite"

        val first = openIosProbeDatabase(path)
        try {
            first.contacts().upsert(ProbeContact("12025550124", "Fictional A"))
            first.contacts().upsert(ProbeContact("442071234567", "Fictional B"))
            assertEquals(2, first.contacts().all().size)
            first.contacts().upsert(ProbeContact("12025550124", "Updated A"))
        } finally {
            first.close()
        }

        val reopened = openIosProbeDatabase(path)
        try {
            assertEquals("Updated A", reopened.contacts().findByNumber("12025550124")?.visibleAlias)
            assertEquals(listOf("12025550124", "442071234567"),
                reopened.contacts().all().map { it.phoneDigits })
            reopened.contacts().deleteByNumber("12025550124")
            assertNull(reopened.contacts().findByNumber("12025550124"))
            assertEquals(1, reopened.contacts().all().size)
        } finally {
            reopened.close()
        }
    }
}
