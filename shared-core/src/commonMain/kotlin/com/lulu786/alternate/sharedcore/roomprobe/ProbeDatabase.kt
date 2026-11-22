package com.lulu786.alternate.sharedcore.roomprobe

import androidx.room.ConstructedBy
import androidx.room.Dao
import androidx.room.Database
import androidx.room.Entity
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.PrimaryKey
import androidx.room.Query
import androidx.room.RoomDatabase
import androidx.room.RoomDatabaseConstructor

/**
 * Throwaway private address-book persistence proof, NOT Alternate's schema v5.
 * Never write data to the existing Android caller_database path.
 */
@Entity(tableName = "probe_contacts")
data class ProbeContact(
    @PrimaryKey val phoneDigits: String,
    val visibleAlias: String
)

@Dao
interface ProbeContactDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsert(contact: ProbeContact)

    @Query("SELECT * FROM probe_contacts ORDER BY phoneDigits")
    suspend fun all(): List<ProbeContact>

    @Query("SELECT * FROM probe_contacts WHERE phoneDigits = :number LIMIT 1")
    suspend fun findByNumber(number: String): ProbeContact?

    @Query("DELETE FROM probe_contacts WHERE phoneDigits = :number")
    suspend fun deleteByNumber(number: String)
}

@Database(entities = [ProbeContact::class], version = 1, exportSchema = true)
@ConstructedBy(ProbeDatabaseConstructor::class)
abstract class ProbeDatabase : RoomDatabase() {
    abstract fun contacts(): ProbeContactDao
}

// Generated actual objects come from KSP on each platform.
@Suppress("KotlinNoActualForExpect", "NO_ACTUAL_FOR_EXPECT")
expect object ProbeDatabaseConstructor : RoomDatabaseConstructor<ProbeDatabase> {
    override fun initialize(): ProbeDatabase
}
