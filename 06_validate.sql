-- ============================================================
--  Step 6: Validate — 
-- ============================================================

USE BikeStore;
GO

-- عرض كل الجداول مع عدد الصفوف
SELECT
    s.name  AS schema_name,
    t.name  AS table_name,
    p.rows  AS row_count
FROM       sys.tables     t
INNER JOIN sys.schemas    s ON s.schema_id = t.schema_id
INNER JOIN sys.partitions p ON p.object_id = t.object_id
                            AND p.index_id IN (0,1)
WHERE s.name IN ('Sales','Production')
ORDER BY s.name, t.name;
GO

-- عرض كل الـ Foreign Keys
SELECT
    fk.name                        AS fk_name,
    OBJECT_NAME(fk.parent_object_id) AS from_table,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS from_column,
    OBJECT_NAME(fk.referenced_object_id) AS to_table,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS to_column
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
ORDER BY from_table;
GO

PRINT '=== Validation complete ===';
GO
