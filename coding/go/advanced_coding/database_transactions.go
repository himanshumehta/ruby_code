Database Transactions:
// Wrong Approach: Using multiple SQL statements without wrapping them in a transaction, leading to inconsistent or incomplete database updates in case of failures.
_, err1 := db.Exec("UPDATE table1 SET column1 = value1 WHERE id = 1")
_, err2 := db.Exec("UPDATE table2 SET column2 = value2 WHERE id = 2")

// Right Approach: Using transactions to ensure atomicity and consistency in database updates, rolling back changes in case of failures.
tx, err := db.Begin()
if err != nil {
    // handle the error
}
_, err1 := tx.Exec("UPDATE table1 SET column1 = value1 WHERE id = 1")
_, err2 := tx.Exec("UPDATE table2 SET column2 = value2 WHERE id = 2")
if err1 != nil || err2 != nil {
    tx.Rollback()
    // handle the error
}
tx.Commit()
