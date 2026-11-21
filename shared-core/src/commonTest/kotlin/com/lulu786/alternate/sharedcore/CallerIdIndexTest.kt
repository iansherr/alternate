package com.lulu786.alternate.sharedcore

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith

class CallerIdIndexTest {
    @Test fun sortedByNumericValue() {
        val result = prepareCallerIdIndex(listOf(
            CallerIdEntry("442071234567", "London Office"),
            CallerIdEntry("12025550124", "Work contact"),
            CallerIdEntry("1800", "Test short"),
        ))
        assertEquals(listOf("1800", "12025550124", "442071234567"), result.map { it.digits })
    }

    @Test fun rejectsDuplicateNumbersAndInvalidInput() {
        assertFailsWith<IllegalArgumentException> {
            prepareCallerIdIndex(listOf(CallerIdEntry("12025550124", "First"), CallerIdEntry("12025550124", "Second")))
        }
        for (bad in listOf("", "+12025550124", "012025550124", "abc", "1".repeat(16))) {
            assertFailsWith<IllegalArgumentException> {
                prepareCallerIdIndex(listOf(CallerIdEntry(bad, "Test")))
            }
        }
        assertFailsWith<IllegalArgumentException> {
            prepareCallerIdIndex(listOf(CallerIdEntry("12025550124", "  ")))
        }
    }
}
