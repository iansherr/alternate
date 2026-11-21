package com.lulu786.alternate.sharedcore

/**
 * A deliberately minimal caller-ID index entry, independent of Android and iOS SDK APIs.
 *
 * This is a proof-of-concept contract only, NOT a production import, permission, or
 * persistence implementation. Never put a full Contact record into the caller index.
 * [digits] is an international telephone identifier, without '+' and leading zeroes.
 */
data class CallerIdEntry(val digits: String, val visibleAlias: String)

/**
 * Validate, sort, and de-duplicate a small test index.
 *
 * Fail closed on ambiguous numbers or sensitive-looking invalid entries, rather than
 * guessing which person owns a number. Caller consent and proper international
 * number parsing belong to later domain work.
 */
fun prepareCallerIdIndex(entries: List<CallerIdEntry>): List<CallerIdEntry> {
    val seen = mutableSetOf<String>()
    for (entry in entries) {
        require(entry.digits.length in 1..15 && entry.digits.all(Char::isDigit) && entry.digits[0] != '0') {
            "Caller number must be 1–15 international digits without leading zero"
        }
        require(entry.visibleAlias.isNotBlank()) { "A visible caller alias is required" }
        require(seen.add(entry.digits)) { "Conflicting caller index entries are not allowed" }
    }
    return entries.sortedWith(compareBy<CallerIdEntry> { it.digits.length }.thenBy { it.digits })
}
