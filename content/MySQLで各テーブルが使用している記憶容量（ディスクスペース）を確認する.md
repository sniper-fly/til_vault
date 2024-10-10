---
tags:
  - mysql
  - SQL
---
MySQLで各テーブルが使用している記憶容量（ディスクスペース）を確認する
```sql
SELECT 
    table_schema AS `Database`, 
    table_name AS `Table`, 
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS `Size_MB`,
    ROUND(data_length / 1024 / 1024, 2) AS `Data_MB`,
    ROUND(index_length / 1024 / 1024, 2) AS `Index_MB`
FROM 
    information_schema.tables
WHERE 
    table_schema = 'your_database_name'
ORDER BY 
    `Size_MB` DESC;
```